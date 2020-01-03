require __dir__ + "/Parser"

class Computer
    @memory
    @parser

    def get idxMemory
        return @memory[idxMemory]
    end

    def getParameterCount command
        case command
            when 1, 2
                return 3
            when 99
                return 0
            else
                fail NotImplementedError, "No parameter count is defined for command " + command.to_s
        end
    end

    def getParameterValues command
        _parameterCount = getParameterCount command
        _parameters = Array.new

        for _idxParameter in 0.._parameterCount - 1
            _parameters << @parser.next
        end

        return _parameters
    end

    def initialize
        @parser = Parser.new
    end

    def load intcode
        @parser.load intcode
        @parser.first

        @memory = Array.new

        loop do
            @memory[@parser.cursor] = @parser.current

            if @parser.eof
                break
            end

            @parser.next
        end

        return @memory.count
    end

    def put idxMemory, input
        @memory[idxMemory.to_i] = input.to_i
        return @memory[idxMemory.to_i]
    end

    def run
        @parser.first

        loop do
            _command = @parser.current
            _parameters = getParameterValues _command
            send("command" + _command.to_s.rjust(2, "0"), _parameters)

            if _command == 99 || @parser.eof
                break
            end

            @parser.next
        end
    end

    def command01 parameters
        # puts "command01: " + parameters.inspect
        _idxOperand1 = parameters[0]
        _idxOperand2 = parameters[1]
        _idxDestination = parameters[2]
        # puts "Adding " + @memory[_idxOperand1].to_s + " to " + @memory[_idxOperand2].to_s + " and storing " + (@memory[_idxOperand1] + @memory[_idxOperand2]).to_s + " at " + _idxDestination.to_s

        @memory[_idxDestination] = @memory[_idxOperand1] + @memory[_idxOperand2]
        return @memory[_idxDestination]
    end

    def command02 parameters
        # puts "command02: " + parameters.inspect
        _idxOperand1 = parameters[0]
        _idxOperand2 = parameters[1]
        _idxDestination = parameters[2]
        # puts "Multiplying " + @memory[_idxOperand1].to_s + " by " + @memory[_idxOperand2].to_s + " and storing " + (@memory[_idxOperand1] * @memory[_idxOperand2]).to_s + "  at " + _idxDestination.to_s

        @memory[_idxDestination] = @memory[_idxOperand1] * @memory[_idxOperand2]
        return @memory[_idxDestination]
    end

    def command99 parameters
        # puts @memory[0].to_s
        return @memory[0]
    end

    private :getParameterValues
end