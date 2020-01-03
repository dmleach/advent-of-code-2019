class Parser
    @cursor = nil
    @intcode = nil

    def current
        return @intcode[@cursor].to_i
    end

    def cursor
        return @cursor
    end

    def eof
        return @cursor >= @intcode.count - 1
    end

    def first
        @cursor = 0
        return current
    end

    def load intcode
        if intcode.is_a? String
            @intcode = intcode.split(",")
        elsif intcode.is_a? Array
            @intcode = intcode
        end

        first
        return @intcode.count
    end

    def next
        if eof
            return nil
        end

        @cursor += 1
        return current
    end
end