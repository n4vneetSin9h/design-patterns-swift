import Foundation

class Document {
    
}

protocol Machine {
    func print(d: Document)
    func scan(d: Document) throws
    func fax(d: Document) throws
}

enum NoRequiredFunctionality: Error {
    case doesNotFax
    case doesNotScan
}

class MFP: Machine {
    func print(d: Document) {
        
    }
    func scan(d: Document) {
        
    }
    func fax(d: Document) {
        
    }
}

class OFP: Machine {
    func print(d: Document) {
        
    }
    func scan(d: Document) throws {
        throw NoRequiredFunctionality.doesNotScan
    }
    func fax(d: Document) throws {
        throw NoRequiredFunctionality.doesNotFax
    }
}

protocol Printer {
    func print(d: Document)
}

protocol Scanner {
    func scan(d: Document)
}

protocol FaxMachine {
    func fax(d: Document)
}

class OrdinaryPrinter: Printer {
    func print(d: Document) {
        
    }
}

class PhotoCopier: Scanner, FaxMachine {
    func scan(d: Document) {
        
    }
    
    func fax(d: Document) {
        
    }
}

protocol MultiFunctionDevice: Printer, Scanner, FaxMachine {
    
}

class MultiFunctionMachine: MultiFunctionDevice {
    let printer: Printer
    let scanner: Scanner
    
    init(printer: Printer, scanner: Scanner) {
        self.printer = printer
        self.scanner = scanner
    }
    
    func print(d: Document) {
        printer.print(d: d)
    }
    
    func scan(d: Document) {
        scanner.scan(d: d)
    }
    
    func fax(d: Document) {
        
    }
}
