import Foundation

class Journal: CustomStringConvertible {
    var entries = [String]()
    var count = 0

    func addEntry(_ entry: String) -> Int {
        count += 1
        entries.append(entry)
        return count - 1
    }

    func removeEntry(_ index: Int) {
        entries.remove(at: index)
        count -= 1
    }

    var description: String {
        return entries.joined(separator: "\n")
    }

    // Violation to Single Responsibility Principle
     func save(_ filename: String, overwrite: Bool = false) {

     }

     func load(_ filename: String) {}
     func load(_ url: URL) {}
}

// Separation of concerns
class Persistence {
    func save(_ filename: String, overwrite: Bool = false) {

    }

    func load(_ filename: String) {}
    func load(_ url: URL) {}
}
