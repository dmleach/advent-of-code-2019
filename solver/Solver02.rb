require __dir__ + "/BaseSolver"
require __dir__ + "/../intcode/Computer"

class Solver02 < BaseSolver
    @solution

    def displaySolution mode
        puts @solution
    end 

    def processInput(input, mode)
        if mode == 1
            processInputMode1(input)
        end

        if mode == 2
            processInputMode2(input)
        end
    end

    def processInputMode1(input)
        _computer = Computer.new
        _computer.load input
        _computer.put 1, 12
        _computer.put 2, 2
        _computer.run
        @solution = _computer.get 0
    end

    def processInputMode2(input)
        _computer = Computer.new
        _noun = 0
        _verb = 0

        loop do
            _computer.load input
            _computer.put 1, _noun
            _computer.put 2, _verb
            _computer.run

            if (_computer.get 0) == 19690720
                @solution = _noun * 100 + _verb
                return
            end

            _noun = _noun + 1

            if _noun > 99
                _noun = 0
                _verb = _verb + 1
            end

            if _verb > 99
                @solution = -1
                return
            end
        end
    end
end