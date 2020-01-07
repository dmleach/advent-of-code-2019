require __dir__ + "/../Parser"
require __dir__ + "/../Parameter"

class BaseCommand
    @parameters

    def getParameterCount
        return 0
    end

    def getParameterModes intcode
        _intcodeInteger = Integer(intcode) rescue false

        if _intcodeInteger === false
            raise TypeError, "getParameterModes expects an integer (received " + intcode.to_s + ")"
        end

        _parameterModesInteger = (_intcodeInteger / 100).truncate()
        _parameterModes = Array.new

        while _parameterModesInteger > 0
            _parameterMode = _parameterModesInteger % 10
            _parameterModes << _parameterMode
            _parameterModesInteger = (_parameterModesInteger / 10).truncate()
        end

        return _parameterModes
    end

    def getOpcode
        return 0
    end

    def load intcodeArray
        _parameterModes = getParameterModes intcodeArray.shift

        while _parameterModes.count < getParameterCount
            _parameterModes << 0
        end

        @parameters = Array.new

        while intcodeArray.count > 0
            _parameter = Parameter.new intcodeArray.shift, _parameterModes.shift
            @parameters << _parameter
        end
    end

    def to_s
        _stringValue = "Opcode: " + self.getOpcode.to_s + ", parameters: "

        @parameters.each do |_parameter|
            _stringValue += "(" + _parameter.to_s + "), "
        end

        return _stringValue.delete_suffix(", ")
    end
end