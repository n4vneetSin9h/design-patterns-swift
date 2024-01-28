import Foundation

protocol HotDrink {
    func consume()
}

class Tea: HotDrink {
    func consume() {
        print("This tea is nice but I prefer it with milk.")
    }
}

class Coffee: HotDrink {
    func consume() {
        print("This coffee is delicious")
    }
}

protocol HotDrinkFactory {
    init()
    func prepare(amount: Int) -> HotDrink
}

class TeaFactory: HotDrinkFactory {
    required init() {}

    func prepare(amount: Int) -> HotDrink {
        print("Put in the tea bag, boil water, pour \(amount)ml, add lemon, enjoy!");
        return Tea()
    }
}

class CoffeeFactory: HotDrinkFactory {
    required init() {}

    func prepare(amount: Int) -> HotDrink {
        print("Grind some bean, boil water, pour \(amount)ml, add cream and sugar, enjoy!");
        return Coffee()
    }
}

class HotDrinkMachine {
    enum AvailableDrink: String {
        case coffee = "Coffee"
        case tea = "Tea"

        static let all = [coffee, tea]
    }

    internal var factories = [AvailableDrink: HotDrinkFactory]()

    internal var namedFactories = [(String, HotDrinkFactory)]()

    init() {
        for drink in AvailableDrink.all {
            if let type = NSClassFromString("abstract_factory_pattern.\(drink.rawValue)Factory") as? HotDrinkFactory.Type {
                let facotry = (type).init()
                factories[drink] = facotry 
                namedFactories.append((drink.rawValue, facotry))
            } else {
                print("Failed to find available drinks!")
            }
            
        }
    }

    func makeDrink() -> HotDrink? {
        print("Available drinks")
        for i in 0..<namedFactories.count {
            let tuple = namedFactories[i]
            print("\(i): \(tuple.0)")
        }

        if let input = readLine(), let inputValue = Int(input) {
            return namedFactories[inputValue].1.prepare(amount: 250)
        }
        print("Incorrect input!")
        return nil
    }
}

func main() {
    let machine = HotDrinkMachine()
    print(machine.namedFactories.count)

    if let drink = machine.makeDrink() {
        drink.consume()
    }
}
main()