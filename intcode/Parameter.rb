class Parameter
    @mode
    @value

    def getValue computer
        case @mode
            when 0
                return computer.get(@value)
            when 1
                return @value
        end
        
        return nil
    end

    def initialize value, mode = 0
        @value = Integer(value) rescue false

        if @value === false
            raise TypeError, "Parameter value must be an integer (received " + value.to_s + ")"
        end

        @mode = Integer(mode) rescue false

        if @mode === false
            raise TypeError, "Parameter mode must be an integer (received " + mode.to_s + ")"
        end
    end

    def to_s
        return "Value: " + @value.to_s + ", mode: " + @mode.to_s
    end

end