require __dir__ + "/BaseSolver"

class Solver02 < BaseSolver
    @solution

    def displaySolution mode
        puts "Value zero is " + @solution.to_s
    end 

    def initializeSolution
        @solution = -1
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
        _inputValues = input.split(",")
        _inputValues[1] = 12
        _inputValues[2] = 2
        @solution = runIntcode(_inputValues) 
    end

    def processInputMode2(input)
        _noun = 0
        _verb = 0

        loop do
            _inputValues = input.split(",")
            _inputValues[1] = _noun
            _inputValues[2] = _verb
            _valueZero = runIntcode(_inputValues)

            if _valueZero == 19690720
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

    def runIntcode(memory) 
         memory.each_with_index do |_inputValue, _idxInput|
            if _idxInput % 4 != 0
                next
            end

            _command = memory[_idxInput].to_i

            if _command == 99
                return memory[0]
            end

            _idxOperand1 = memory[_idxInput + 1].to_i
            _idxOperand2 = memory[_idxInput + 2].to_i
            _idxDestination = memory[_idxInput + 3].to_i

            if _command == 1
                memory[_idxDestination] = memory[_idxOperand1].to_i + memory[_idxOperand2].to_i
            end

            if _command == 2
                memory[_idxDestination] = memory[_idxOperand1].to_i * memory[_idxOperand2].to_i
            end
        end
    end
end