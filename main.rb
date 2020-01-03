problem = "02"

className = "Solver" + problem

classFile = "./solver/" + className
require classFile

solver = Object::const_get(className).new

inputFileName = "./input/input" + problem + ".txt"
solver.solve inputFileName, 1
solver.solve inputFileName, 2


# inputFileName = "./input/input02.txt"
# require "./intcode/Computer"
# _computer = Computer.new

# IO.foreach(inputFileName) do |input|
#     puts "Input " + (_computer.load input).to_s + " values"
#     _computer.put 1, 12
#     _computer.put 2, 2
#     _computer.run
#     puts _computer.get 0
    
# end