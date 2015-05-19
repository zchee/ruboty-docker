module Ruboty
    module Docker
        module Actions
            class Thread < Base
                def call
                    thread =  ::Thread
                    current = thread::current
                    thread::list.each do |t|
                        t != current ? message.reply('--------------------------------------------------') : message.reply('--------------- Current Thread ---------------')
                        message.reply(t)
                        message.reply(t.status)
                        message.reply(t.inspect)
                    end
                rescue => e
                    value = [e.class.name, e.message, e.backtrace].join("\n")
                    message.reply value
                ensure
                end
            end
        end
    end
end
