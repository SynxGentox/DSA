//
//  D_Bitmask.swift
//  
//
//  Created by Aryan Verma on 03/06/26.
//

import Foundation

class BitmaskBottomUp {
    let s: String
    let n: Int64
    
    init(s: String, n: Int64) {
        self.s = s
        self.n = n
    }
    
    func solve() {
        let binaryMap: [Character] = Array(s)
        var sum: Int64 = 0
        
        for (index, char) in binaryMap.enumerated() {
            let bitPosition = binaryMap.count - 1 - index
            
            if char == "1" {
                sum += (1 as Int64) << bitPosition
            }
        }
        
        if sum > n {
            print("-1")
            return
        }
        
        for (index, char) in binaryMap.enumerated() {
            if char == "?" {
                let bitPosition = binaryMap.count - 1 - index
                let bitValue = (1 as Int64) << bitPosition
                
                if sum + bitValue <= n {
                    sum += bitValue
                }
            }
        }
        
        print(sum)
    }
}

if let sInput = readLine(), let nInputStr = readLine(), let nInput = Int64(nInputStr) {
    let solver = BitmaskBottomUp(s: sInput, n: nInput)
    solver.solve()
}
