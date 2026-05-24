//
//  C_Cross.swift
//  
//
//  Created by Aryan Verma on 24/05/26.
//

import Foundation

class CrossCount {
    let h: Int
    let w: Int
    var arrayCross: [[Character]]
    init(h: Int, w: Int, arrayCross: [[Character]]) {
        self.h = h
        self.w = w
        self.arrayCross = arrayCross
    }
    
    func main() {
        let maxXSize: Int = min(h, w)
        var sizeArray: [Int] = Array(repeating: 0, count: maxXSize)
        
        for i in 1..<(h - 1) {
            for j in 1..<(w - 1) {
                if !(arrayCross[i][j] == "#" && arrayCross[i - 1][j + 1] == "#" && arrayCross[i + 1][j - 1] == "#" && arrayCross[i + 1][j + 1] == "#" && arrayCross[i - 1][j - 1] == "#") {
                    continue
                }
                
                var k = 1
                while i + k < h && j + k < w && arrayCross[i + k][j + k] == "#" {
                    k += 1
                }
                let actualSize = k - 1
                sizeArray[actualSize - 1] += 1
            }
        }
        let resultString = sizeArray.map { String($0) }.joined(separator: " ")
        print(resultString)
    }
}

let hw = readLine()!.split(separator: " ").map { Int($0)! }
let h = hw[0], w = hw[1]

var grid: [[Character]] = []
for _ in 0..<h {
    grid.append(Array(readLine()!))
}

let solver = CrossCount(h: h, w: w, arrayCross: grid)
solver.main()
