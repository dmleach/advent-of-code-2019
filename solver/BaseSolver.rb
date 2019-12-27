class BaseSolver
    def displaySolution
        fail NotImplementedError, "A Solver class must define displaySolution"
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