require __dir__ + "/Command"
require __dir__ + "/Parameter"
require __dir__ + "/Parser"

class Computer
    @commands
    @memory
    @shouldStop

    def get idxMemory
        return @memory[idxMemory]
    end

    def load intcode
       loadCommands intcode
       loadMemory intcode
    end

    def loadCommands intcode
        _parser = Parser.new
        _parser.load intcode
        _parser.first

        @commands = Array.new

        loop do
            _command = Command.instantiate _parser
            @commands << _command

            if _parser.eof
                break
            end

            _parser.next
        end

        return @commands.count
    end 

    def loadMemory intcode
        _parser = Parser.new
        _parser.load intcode
        _parser.first

        @memory = Array.new
            
        loop do
            @memory[_parser.cursor] = _parser.current

            if _parser.eof
                break
            end

            _parser.next
        end

        return @memory.count
    end

    def put! idxMemory, input
        @memory[idxMemory.to_i] = input.to_i
        return @memory[idxMemory.to_i]
    end

    def run
        _lastResult = nil
        @shouldStop = false

        @commands.each do |_command|
            _result = _command.run self

            if _result != nil
                _lastResult = _result
            end

            if @shouldStop
                break
            end
        end

        return _lastResult
    end

    def stop
        @shouldStop = true
    end

end