//
//  E_Dice Product 3.swift
//  
//
//  Created by Aryan Verma on 28/05/26.
//

import Foundation

class DiceProduct3 {
    var resultDict: [Int64: Int64] = [:]
    var n: Int64
    var probability = 0
    
    init (n: Int64) {
        self.n = n
    }
    
    func findProbability(for current: Int64) -> Int64 {
        if current > n { return 0 }
        if current == n { return 1 }
        if let saved = resultDict[current] { return saved }
        
        var total: Int64 = 0
        
        for die in 2...6 {
            var next: Int64 = current * Int64(die)
            total = (total + findProbability(for: next)) % 998244353
        }
        
        total = (total * 598946612) % 998244353
        resultDict[current] = total
        return total
    }
    
    func main() {
           print(findProbability(for: 1))
    }
}

if let input = readLine(), let n = Int64(input) {
    let solve = DiceProduct3(n: n)
    solve.main()
}
