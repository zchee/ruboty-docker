module Ruboty
    module Docker
        module Actions
            class Build < Ruboty::Actions::Base
                def call
                    message_args = message[:code].to_s.split("\n", 2)
                    repo_name    = message_args[0].split(':')[0]
                    tag          = message_args[0].split(':')[1]
                    dockerfile   = message_args[1].to_s[4..-5]

                    message.reply('Building this Dockerfile...')
                    message.reply(dockerfile, code: true)
                    build = ::Docker::Image.build(dockerfile).tag(repo: repo_name, tag: tag)
                    ap build
                    ap repo_name
                    ap dockerfile
                    message.reply('Done')
                rescue => e
                    value = [e.class.name, e.message, e.backtrace].join("\n")
                    message.reply value
                ensure
                end
            end
        end
    end
end
