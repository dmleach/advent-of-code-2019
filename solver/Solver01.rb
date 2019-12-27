require __dir__ + "/BaseSolver"

class Solver01 < BaseSolver
    def calculateFuel(mass)
        return mass.div(3) - 2
    end

    def displaySolution mode
        puts "The fuel needed is " + @totalFuel.to_s
    end

    def initializeSolution
        @totalFuel = 0
    end

    def processInput(input, mode)
        if (mode == 1)
            @totalFuel += calculateFuel(input.to_i)
        end

        if (mode == 2)
            _neededFuel = calculateFuel(input.to_i)

            while _neededFuel > 0
                @totalFuel += _neededFuel
                _neededFuel = calculateFuel(_neededFuel)
            end
        end
    end
end