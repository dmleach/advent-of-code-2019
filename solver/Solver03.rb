require __dir__ + "/BaseSolver"

class WireSegment
    def initialize currentPosition, description
        @startPosition = currentPosition
        @direction = description[0]
        @length = description[1, description.length].to_i
    end

    def column
        if orientation == "V"
            return @startPosition[0]
        end

        raise RuntimeError "Vertical wires don't have a column value"
    end

    def direction
        return @direction
    end

    def endPosition
        _startColumn = @startPosition[0]
        _startRow = @startPosition[1]

        case @direction
            when "D"
                return [_startColumn, _startRow - @length]
            when "L"
                return [_startColumn - @length, _startRow]
            when "R"
                return [_startColumn + @length, _startRow]
            when "U"
                return [_startColumn, _startRow + @length]
            else
                raise ArgumentError, "Invalid direction: " + @direction
        end
    end

    def getIntersection segment
        if orientation == segment.orientation
            return nil
        end

        if orientation == "H"
            if (segment.range[0] <= row) && (segment.range[1] >= row) && (range[0] <= segment.column) && (range[1] >= segment.column)
                return [segment.column, row]
            end
        elsif orientation == "V"
            if (segment.range[0] <= column) && (segment.range[1] >= column) && (range[0] <= segment.row) && (range[1] >= segment.row)
                return [column, segment.row]
            end
        else
            raise ArgumentError, "Invalid orientation: " + orientation
        end

        return nil
    end

    def length
        return @length
    end

    def orientation
        case @direction
            when "D", "U"
                return "V"
            when "L", "R"
                return "H"
        end

        raise ArgumentError, "Invalid direction: " + @direction
    end

    def range
        if orientation == "H"
            return [@startPosition[0], endPosition[0]].sort
        elsif orientation == "V"
            return [@startPosition[1], endPosition[1]].sort
        end

        raise ArgumentError, "Invalid orientation: " + orientation
    end

    def row
        if orientation == "H"
            return @startPosition[1]
        end

        raise RuntimeError "Horizontal wires don't have a row value"
    end

    def to_s
        @startPosition.to_s + " to " + endPosition.to_s
    end
end

class Solver03 < BaseSolver
    @segments

    def displaySolution mode
        _closestIntersectionToOrigin = nil
        _closestIntersectionDistance = 9999999999
        _shortestCircuitLength = 999999999

        _wire1Length = 1

        @segments[0].each do |_segment|
            _wire1Length = _wire1Length + _segment.length - 1
        end

        _wire2Length = 1

        @segments[1].each do |_segment|
            _wire2Length += _wire2Length + _segment.length - 1
        end

        _wire1LengthToStart = 1

        @segments[0].each_with_index do |_segment1, _idxSegment1|
            _wire1LengthToStart += _segment1.length - 1
            _wire2LengthToStart = 1

            @segments[1].each_with_index do |_segment2, _idxSegment2|
                _wire2LengthToStart += _segment2.length - 1

                if _segment1.orientation == _segment2.orientation
                    next
                end

                _intersection = _segment1.getIntersection _segment2

                if _intersection == nil
                    next
                end

                if _intersection[0] == 0 and _intersection[1] == 0
                    next
                end
                
                if mode == 1
                    if _intersection[0].abs + _intersection[1].abs < _closestIntersectionDistance
                        _closestIntersectionToOrigin = _intersection
                        _closestIntersectionDistance = _intersection[0].abs + _intersection[1].abs
                    end
                end

                if mode == 2
                    _wire1LengthToOrigin = _wire1LengthToStart

                    if _wire1Length - _wire1LengthToStart < _wire1LengthToOrigin
                        _wire1LengthToOrigin = _wire1Length - _wire1LengthToStart
                    end

                    _wire2LengthToOrigin = _wire2LengthToStart

                    if _wire2Length - _wire2LengthToStart < _wire2LengthToOrigin
                        _wire2LengthToOrigin = _wire2Length - _wire2LengthToStart
                    end

                    if _wire1LengthToOrigin + _wire2LengthToOrigin < _shortestCircuitLength
                        _shortestCircuitLength = _wire1LengthToOrigin + _wire2LengthToOrigin
                    end
                end
            end
        end

        if mode == 1
            puts "The closest intersection to the origin is " + _closestIntersectionDistance.to_s + " away at " + _closestIntersectionToOrigin.to_s
        end

        if mode == 2
            puts "The shortest circult length is " + _shortestCircuitLength.to_s
        end
    end

    def initializeSolution
        @segments = Array.new
    end

    def processInput input, mode
        _segments = Array.new
        _inputValues = input.split(",")
        _currentPosition = [0,0]

        _inputValues.each do |_inputValue|
            _segment = WireSegment.new(_currentPosition, _inputValue)
            _currentPosition = _segment.endPosition
            _segments << _segment
        end

        @segments << _segments
    end
end