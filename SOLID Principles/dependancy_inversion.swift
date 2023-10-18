//
//  dependancy_inversion.swift
//  
//
//  Created by Navneet Singh on 19/10/23.
//

import Foundation

enum Relationship {
    case parent
    case child
    case sibling
}

protocol RelationshipBrowser {
    func findAllChilder(of name: String) -> [Person]
}

class Person {
    var name: String
    init(name: String) {
        self.name = name
    }
}

class Relationships: RelationshipBrowser { // Low Level
    private var relations = [(Person, Relationship, Person)]()
    
    func addParentAndChild(_ p: Person, _ c: Person) {
        relations.append((p, .parent, c))
        relations.append((c, .child, p))
    }
    
    func findAllChilder(of name: String) -> [Person] {
        return relations
            .filter{$0.name == name && $1 == .parent && $2 === $2}
            .map{$2}
    }
}

class Research { // High Level
//    init(_ relationships: Relationships) {
//        let relations = relationships.relations
//        for r in relations where r.0.name == "John" && r.1 == .parent {
//            print("John has a child called \(r.2.name)")
//        }
//    }
    
    init(_ browser: RelationshipBrowser) {
        for p in browser.findAllChilder(of: "John") {
            print("John has a child called \(p.name)")
        }
    }
}

func main() {
    let parent = Person(name: "John")
    let child1 = Person(name: "Kevin")
    let child2 = Person(name: "Matt")
    
    let relationships = Relationships()
    relationships.addParentAndChild(parent, child1)
    relationships.addParentAndChild(parent, child2)
    
    let _ = Research(relationships)
}


main()

























