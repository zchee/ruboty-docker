module Ruboty
    module Docker
        module Actions
            class Run < Base
                def call
                    image_name = message[:image_name]

                    args = message[:args].gsub(/\"/) { $1 }.split('-')
                    args.each do |a|
                        if /^v/ === a
                            set_volumes(a)
                        elsif /^e/ === a
                            set_env(a)
                        elsif /^link/ === a
                            set_link(a)
                        elsif /^net/ === a
                            set_net(a)
                        else
                            set_command(a)
                        end
                    end
                    image = ::Docker::Container.create('Image' => image_name, 'Binds' => @volume, 'Env' => @env, 'Cmd' => @command)
                    message.reply("Start running the #{image_name}...")
                    ::Thread.new { image.tap(&:start).attach do |stream, chunk|
                        message.reply stream
                        message.reply chunk
                    end }
                rescue => e
                    value = [e.class.name, e.message, e.backtrace].join("\n")
                    message.reply value
                ensure
                end

                private

                def set_volumes(a)
                    @volume = [] << a.sub('v') { $1 }.gsub(' ') { $1 }
                end

                def set_env(a)
                    @env = a.chop.sub(/e /) { $1 }.split(', ')
                end

                def set_link(a)
                    @link = [] << a.sub(/link /) { $1 }.gsub(/\s/) { $1 }
                end

                def set_net(a)
                    @net = [] << a.sub(/net /) { $1 }
                end

                def set_command(a)
                    @command = a.split('/\s/')
                end
            end
        end
    end
end
