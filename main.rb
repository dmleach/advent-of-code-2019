problem = "04"

className = "Solver" + problem

classFile = "./solver/" + className
require classFile

solver = Object::const_get(className).new

inputFileName = "./input/input" + problem + ".txt"
solver.solve inputFileName, 1
solver.solve inputFileName, 2