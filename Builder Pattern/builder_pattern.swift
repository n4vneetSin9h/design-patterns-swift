//
//  builder_pattern.swift
//  
//
//  Created by Navneet Singh on 21/10/23.
//

import Foundation

class HTMLElement: CustomStringConvertible {
    var name = ""
    var text = ""
    var elements = [HTMLElement]()
    private let indentSize = 2
    
    init() {
        
    }
    init(name: String = "", text: String = "", elements: [HTMLElement] = [HTMLElement]()) {
        self.name = name
        self.text = text
        self.elements = elements
    }
    
    private func description(_ indent: Int) -> String {
        var result = ""
        let i = String(repeating: " ", count: indent)
        result += "\(i)<\(name)>\n"
        
        if !text.isEmpty {
            result += String(repeating: " ", count: (indent + 1))
            result += text
            result += "\n"
        }
        
        for e in elements {
            result += e.description(indent+1)
        }
        
        result += "\(i)</\(name)>\n"
        
    }
    
    public var description: String {
        return description(0)
    }
}

class HTMLBuilder: CustomStringConvertible {
    private let rootName: String
    var root = HTMLElement()
    
    init(rootName: String, root: HTMLElement = HTMLElement()) {
        self.root = root
        self.rootName = rootName
        root.name = rootName
    }
    
    func addChild(name: String, text: String) {
        let e = HTMLElement(name: name, text: text)
        root.elements.append(e)
    }
    
    func addChildFluent(name: String, text: String) -> HTMLBuilder {
        let e = HTMLElement(name: name, text: text)
        root.elements.append(e)
        return self
    }
    
    var description: String {
        return root.description
    }
    
    func clear() {
        root = HTMLElement(name: rootName, text: "")
    }
}

func main() {
    let hello = "hello"
    var result = "<p>\(hello)</p>"
    print(result)
    
    let words = ["hello", "world"]
    result = "<ul>\n"
    for word in words {
        result.append("<li>\(word)</li>")
    }
    result.append("</ul>")
    print(result)
    
    let builder = HTMLBuilder(rootName: "ul").addChildFluent(name: "li", text: "hello").addChildFluent(name: "li", text: "world")
    print(builder)
}

main()
