import Foundation

class Point: CustomStringConvertible {
    private var x, y: Double

    private init(x: Double, y: Double) {
        self.x = x
        self.y = y
    }
    
    private init(rho: Double, theta: Double) {
        x = rho * cos(theta)
        y = rho * sin(theta)
    }

    var description: String {
        return "Point is at (x:\(x), y:\(y))"
    }

    static let factory = Factory.instance

    class Factory {
        private init () {}

        static let instance = Factory()

        static func createCartesian(x: Double, y: Double) -> Point {
            return Point(x:x, y: y)
        }

        static func createPolar(rho: Double, theta: Double) -> Point {
            return Point(rho:rho, theta: theta)
        }
    }
}


func main() {
    // let p = Point.createCartesian(x: 200, y: 300)
    // print(p)

    let pF = Point.factory.createCartesian(rho: 2, theta: 1)

}

main()