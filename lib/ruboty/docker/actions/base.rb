module Ruboty
    module Docker
        module Actions
            class Base
                NAMESPACE = 'docker'

                attr_reader :message

                def initialize(message)
                    @message = message
                end

                private

                def filesize_to_human(n)
                    count = 0
                    while n >= 1000 and count < 4
                        n     /= 1000.0
                        count += 1
                    end
                    format('%.2f', n) + %w(B KB MB GB TB)[count]
                end
            end
        end
    end
end
