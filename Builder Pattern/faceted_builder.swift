//
//  faceted_builder.swift
//  
//
//  Created by Navneet Singh on 21/10/23.
//

import Foundation

class Person: CustomStringConvertible {
    // address
    var streetAddress = "", postcode = "", city = ""
    
    // employment
    var companyName = "", position = "", annualIncome = 0
    
    var description: String {
        return "I live at \(streetAddress), \(postcode), \(city). " +
"I work at \(companyName) as a \(position), earning \(annualIncome)"
    }
}

class PersonBuilder {
    var person = Person()
    
    var lives: PersonAddressBuilder {
        return PersonAddressBuilder(person)
    }
    
    var works: PersonJobBuilder {
        return PersonJobBuilder(person)
    }
    
    func build() -> Person {
        return person
    }
}

class PersonJobBuilder: PersonBuilder {
    internal init(_ person: Person) {
        super.init()
        
        self.person = person
    }
    
    func at(_ companyName: String) -> PersonJobBuilder {
        person.companyName = companyName
        return self
    }
    
    func asA(_ position: String) -> PersonJobBuilder {
        person.position = position
        return self
    }
    
    func earning(_ annualIncome: Int) -> PersonJobBuilder {
        person.annualIncome = annualIncome
        return self
    }
}

class PersonAddressBuilder: PersonBuilder {
    internal init(_ person: Person) {
        super.init()
        
        self.person = person
    }
    
    func at(_ streetAddress: String) -> PersonAddressBuilder {
        person.streetAddress = streetAddress
        return self
    }
    
    func withPostCode(_ postcode: String) -> PersonAddressBuilder {
        person.postcode = postcode
        return self
    }
    
    func inCity(_ city: String) -> PersonAddressBuilder {
        person.city = city
        return self
    }
}

func main() {
//    let pb = PersonBuilder()
//    let p = pb
//        .lives.at("123 London Road")
//              .inCity("London")
//              .withPostCode("SW12BC")
//        .works.at("Fabrikam")
//              .as("Engineer")
//              .earning("140K")
//              .build()
    
    let cb = CodeBuilder("Person")
        .addField(called: "name", ofType: "String")
        .addField(called: "age", ofType: "Int")
    print(cb.description)
}


main()

class CodeBuilder : CustomStringConvertible
{
  var rootName: String
  var fields: [String: String] = [:]
  init(_ rootName: String)
  {
    self.rootName = rootName
  }

  func addField(called name: String, ofType type: String) -> CodeBuilder
  {
    // todo
    self.fields[type] = name
    return self
  }

  public var description: String
  {
    // todo
    var fieldsString = ""
    for (type, name) in fields {
        fieldsString.append("\n  var \(name): \(type)")
    }
    return "class \(rootName) {\(fieldsString)\n}"
  }
}
