module Ruboty
    module Docker
        module Actions
            class Images < Base
                def call
                    images = ::Docker::Image.all
                    rows   = []
                    message.reply images if message[:debug] == ' -D '
                    images.each do |image|
                        repository = image.info['RepoTags'].to_s.split(':').first
                        tag        = image.info['RepoTags'].to_s.split(':').last
                        id         = image.info['id'].to_s.scan(/.{1,#{12}}/)
                        size       = filesize_to_human(image.info['VirtualSize'])
                        rows.push [repository[2..100], tag[0..-3], id[0], size]
                    end
                    table       = ::Terminal::Table.new headings: ['REPOSITORY', 'TAG', 'IMAGE ID', 'VIRTUAL SIZE'], rows: rows
                    table.style = { :padding_left => 0, :border_x => '', :border_y => ' ', :border_i => '' }
                    message.reply(table, code: true)
                rescue => e
                    value = [e.class.name, e.message, e.backtrace].join("\n")
                    message.reply value
                ensure
                end
            end
        end
    end
end
