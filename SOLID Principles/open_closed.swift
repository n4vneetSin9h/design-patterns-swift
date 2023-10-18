//
//  open_closed.swift
//
//
//  Created by Navneet Singh on 18/10/23.
//

import Foundation

enum Color: String, CaseIterable {
    case red
    case blue
    case green
    case yellow
}

enum Size: String, CaseIterable {
    case small
    case medium
    case regular
    case large
    case extra_large
}

class Product: CustomStringConvertible {
    var name: String
    var color: Color
    var size: Size
    
    var description: String {
        return "{\n\"name\": \(name),\n\"color\": \(color.rawValue),\n\"size\": \(size.rawValue)\n}"
    }
    
    init(name: String, color: Color, size: Size) {
        self.name = name
        self.color = color
        self.size = size
    }
    
}

class OldFilter {
    
    // Breaking the open close principles. classes should be open for extensions but closed for modifications
    func filter(_ products: [Product], byColor color: Color) -> [Product] {
        var result: [Product] = []
        for p in products {
            if p.color == color {
                result.append(p)
            }
        }
        return result
    }
    
    func filter(_ products: [Product], bySize size: Size) -> [Product] {
        var result: [Product] = []
        for p in products {
            if p.size == size {
                result.append(p)
            }
        }
        return result
    }
    
    func filter(_ products: [Product], bySize size: Size, byColor color: Color) -> [Product] {
        var result: [Product] = []
        for p in products {
            if p.size == size && p.color == color {
                result.append(p)
            }
        }
        return result
    }
}

// Better solution

protocol Specification {
    associatedtype T
    func isSatisfied(_ item: T) -> Bool
}

protocol Filter {
    associatedtype T
    func filter<Spec: Specification>(_ items: [T], spec: Spec) -> [T] where Spec.T == T
}

class ColorSpecification: Specification {
    typealias T = Product
    let color: Color
    
    init(color: Color) {
        self.color = color
    }
    
    func isSatisfied(_ item: Product) -> Bool {
        return item.color == color
    }
}

class SizeSpecification: Specification {
    typealias T = Product
    let size: Size
    
    init(size: Size) {
        self.size = size
    }
    
    func isSatisfied(_ item: Product) -> Bool {
        return item.size == size
    }
}

class AndSpecification<T,
                       SpecA: Specification,
                       SpecB: Specification>: Specification where SpecA.T == SpecB.T, T == SpecA.T, T == SpecB.T {
    let first: SpecA
    let second: SpecB
    init (_ first: SpecA, _ second: SpecB) {
        self.first = first
        self.second = second
    }
    
    func isSatisfied(_ item: T) -> Bool {
        return first.isSatisfied(item) && second.isSatisfied(item)
    }
}

class ProductFilter: Filter {
    typealias T = Product
    
    func filter<Spec: Specification>(_ items: [T], spec: Spec) -> [T] where Spec.T == T {
        var result = [Product]()
        for i in items {
            if spec.isSatisfied(i) {
                result.append(i)
            }
        }
        
        return result
    }
}

func main() {
    
    var products: [Product] = []
    
    for _ in 0..<20 {
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
        
        let name = String((0..<Int.random(in: 5...10)).map{ _ in letters.randomElement()! })
        let color = Color.allCases[Int.random(in: 0..<Color.allCases.count)]
        let size = Size.allCases[Int.random(in: 0..<Size.allCases.count)]
        
        let product = Product(name: name, color: color, size: size)
        
        products.append(product)
    }
    
    
    let bFilter = ProductFilter()
    print("Color filtered:")
    for p in bFilter.filter(products, spec: ColorSpecification(color: .green)) {
        print(p)
    }
    
    print("\n\nLarge & Blue Items")
    for p in bFilter.filter(products, spec: AndSpecification(ColorSpecification(color: .blue), SizeSpecification(size: .large))) {
        print(p)
    }
}

main()
