require __dir__ + "/BaseCommand"

class Command01 < BaseCommand
    def getOpcode
        return 1
    end

    def getParameterCount
        return 3
    end

    def run computer
        _operand1 = @parameters[0].getValue computer
        _operand2 = @parameters[1].getValue computer
        _idxDestination = @parameters[2].getValue computer
        return computer.put! _idxDestination, _operand1 + _operand2
    end
end