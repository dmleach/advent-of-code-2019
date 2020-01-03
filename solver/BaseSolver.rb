class BaseSolver
    def displaySolution mode
        # fail NotImplementedError, "A Solver class must define displaySolution"
        puts '¯\_(ツ)_/¯'
    end

    def initializeSolution
    end

    def processInput(input, mode)
        fail NotImplementedError, "A Solver class must define processInput"
    end

    def solve(inputFilepath, mode)
        initializeSolution

        IO.foreach(inputFilepath) do |input|
            processInput input, mode
        end

        displaySolution mode
    end
end