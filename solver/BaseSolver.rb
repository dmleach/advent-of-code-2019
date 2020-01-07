require 'pathname'

class BaseSolver
    def displaySolution mode
        puts '¯\_(ツ)_/¯'
    end

    def initializeSolution
    end

    def processInput input, mode
    end

    def solve inputFilepath, mode
        initializeSolution

        filepath = Pathname.new(inputFilepath)

        if filepath.exist?
            filepath.each_line do |input|
                processInput input, mode
            end
        end

        displaySolution mode
    end
end