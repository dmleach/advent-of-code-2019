require __dir__ + "/BaseCommand"

class Command99 < BaseCommand
    def getOpcode
        return 99
    end

    def run computer
        computer.stop
        return nil
    end
end