import Foundation

class Rectangle: CustomStringConvertible {
    var _width: Double = 0
    var _height: Double = 0
    
    var width: Double {
        get { return _width }
        set (value) { _width = value }
    }
    
    var height: Double {
        get { return _height }
        set (value) { _height = value }
    }
    
    init() {}
    
    init(_ width: Double, _ height: Double) {
        self._width = width
        self._height = height
    }
    
    var area: Double {
        return width * height
    }
    
    var description: String {
        return "width: \(width), height: \(height)"
    }
}

class Square: Rectangle {
    override var width: Double {
        get { return _width }
        set (value) { _width = value; _height = height }
    }
    override var height: Double {
        get { return _height }
        set (value) { _width = value; _height = height }
    }
}

// Violates Liskov Substitution Principle
func setAndMeasure(_ rc: Rectangle) {
    rc.width = 3
    rc.height = 4
    print("Expected area to be 12 but got \(rc.area)")
}

func main() {
    let rc = Rectangle()
    setAndMeasure(rc)
    
    let sq = Square()
    setAndMeasure(sq)
}

main()
