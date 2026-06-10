//
//  A_Attack.swift
//  
//
//  Created by Aryan Verma on 10/06/26.
//

import Foundation

class Attack {
    let a: Int64
    let b: Int64
    
    init(a: Int64, b: Int64) {
        self.a = a
        self.b = b
    }
    
    func strikesCount() {
        let ans = (a + b - 1) / b
            print(ans)
    }
}

if let line = readLine() {
    let components = line.split(separator: " ")
    
    if let aValue = Int64(components[0]), let bValue = Int64(components[1]) {
        
        let output = Attack(a: aValue, b: bValue)
        output.strikesCount()
        
    }
}
