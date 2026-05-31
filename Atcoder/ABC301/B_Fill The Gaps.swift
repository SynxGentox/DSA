//
//  B_Fill The Gaps.swift
//  
//
//  Created by Aryan Verma on 30/05/26.
//

import Foundation

class FillTheGaps {
    let n: Int
    var a: [Int]
    
    init(n: Int, a: [Int]) {
        self.n = n
        self.a = a
    }
    
    func gapFilled() {
        var newArray = [a[0]]
        
        for i in 0..<(n - 1) {
            let current = a[i]
            let next = a[i+1]
            
            if current - next > 1 {
                let missingRange = ((next + 1)...(current - 1)).reversed()
                newArray.append(contentsOf: missingRange)
            }
            else if next - current > 1 {
                let missingRange = (current + 1)...(next - 1)
                newArray.append(contentsOf: missingRange)
            }
            
            newArray.append(next)
        }
        
        let outputString = newArray.map { String($0) }.joined(separator: " ")
        print(outputString)
    }
}

if let firstLine = readLine(), let n = Int(firstLine) {
    if let secondLine = readLine() {
        let a = secondLine.split(separator: " ").map { Int($0)! }
        let solver = FillTheGaps(n: n, a: a)
        solver.gapFilled()
    }
}
