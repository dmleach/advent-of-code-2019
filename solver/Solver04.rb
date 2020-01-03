require __dir__ + "/BaseSolver"

class StringAnalyzer
    def self.split subject
        _currentGroup = ''
        _groups = Array.new

        for _idxString in 0..subject.length - 1
            _currentGroup = _currentGroup + subject[_idxString]

            if _idxString == subject.length - 1
                _groups << _currentGroup
            elsif subject[_idxString] != subject[_idxString + 1]
                _groups << _currentGroup
                _currentGroup = ''
            end
        end

        return _groups
    end
end

class Solver04 < BaseSolver
    @lowestPassword
    @highestPassword

    def countPasswords mode
        _count = 0

        for _idxPassword in @lowestPassword..@highestPassword
            if isValid _idxPassword, mode
                _count = _count + 1
            end
        end

        return _count
    end

    def displaySolution mode
        _count = countPasswords mode
        puts "In mode " + mode.to_s + ", the number of valid passwords is " + _count.to_s
    end

    def initializeSolution
        @lowestPassword = nil
        @highestPassword = nil
    end

    def isValid password, mode
        if password.to_s.length != 6
            return false
        end

        if password.to_i <= @lowestPassword
            return false
        end

        if password.to_i >= @highestPassword
            return false
        end

        _containsDouble = false
        _groups = StringAnalyzer.split password.to_s

        _groups.each do |_group| 
            if mode == 1 && _group.length >= 2
                _containsDouble = true
            end

            if mode == 2 && _group.length == 2
                _containsDouble = true
            end
        end

        if _containsDouble == false
            return false
        end

        _digits = password.to_s.split(//)

        for _idxDigit in 0.._digits.count - 2
            if _digits[_idxDigit].to_i > _digits[_idxDigit + 1].to_i
                return false
            end
        end

        return true
    end

    def processInput input, mode 
        input = input.to_s.strip

        if @lowestPassword == nil
            @lowestPassword = input.to_i
        elsif @highestPassword == nil
            @highestPassword = input.to_i
        end
    end
end