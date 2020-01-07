require __dir__ + '/command/BaseCommand'

class Command

    def self.instantiate parser
        _opcode = strToOpcode parser.current
        _commandClassName = 'Command' + _opcode.to_s.rjust(2, "0")
        _commandClassFile = __dir__ + "/command/" + _commandClassName
        require _commandClassFile
        _command = Object::const_get(_commandClassName).new

        _intcodeArray = [parser.current]

        for _idxOpcodeArray in 1.._command.getParameterCount
            _intcodeArray << parser.next
        end

        _command.load _intcodeArray

        return _command
    end

    def self.strToOpcode opcodeString
        _opcodeInteger = Integer(opcodeString) rescue false

        if _opcodeInteger === false
            raise TypeError, "strToOpcode requires an integer value (found " + opcodeString.to_s + ")"
        end

        return _opcodeInteger % 100;
    end

end