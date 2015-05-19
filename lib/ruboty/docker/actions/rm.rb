module Ruboty
    module Docker
        module Actions
            class Rm < Base
                def call
                    message.reply('test')
                end
            end
        end
    end
end
