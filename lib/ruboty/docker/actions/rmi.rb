module Ruboty
    module Docker
        module Actions
            class Rmi < Ruboty::Actions::Base
                def call
                    image_name = message[:image_name]
                    message.reply("Deleting from #{image_name}...")
                    image = ::Docker::Image.get(image_name).remove(force: true)
                    message.reply(image, code: true) if message[:debug] == ' -D '
                    message.reply image
                rescue => e
                    value = [e.class.name, e.message, e.backtrace].join("\n")
                    message.reply value
                ensure
                end
            end
        end
    end
end
