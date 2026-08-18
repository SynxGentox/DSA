//
//  D _ Impartial Gift .swift
//  
//
//  Created by Aryan Verma on 17/08/26.
//

import Foundation

struct PairMaxSum {
    let n: Int
    let m: Int
    let d: Int64
    let groupA: [Int64]
    let groupB: [Int64]
    
    func bestMatch(for num: Int64, in groupB: [Int64]) -> Int64 {
        var low = 0
        var high = m - 1
        var bestOption: Int64 = -1
        
        while (low <= high) {
            let mid = low + (high - low) / 2
            
            if num >= groupB[mid] {
                bestOption = groupB[mid]
                low = mid + 1
            } else {
                high = mid - 1
            }
        }
        return bestOption
    }
    
    func getSum() -> Int64 {
        var maxSum: Int64 = -1
        let sortedB = groupB.sorted()
        for x in groupA {
            let target = x + d
            let y = bestMatch(for: target, in: sortedB)
            if y != -1 && y >= (x - d) {
                maxSum = max(maxSum, x + y)
            }
        }
        return maxSum
    }
}

let firstLine = readLine()!.split(separator: " ").map { Int64($0)! }
let n = Int(firstLine[0])
let m = Int(firstLine[1])
let d = firstLine[2]

let groupA = readLine()!.split(separator: " ").map { Int64($0)! }
let groupB = readLine()!.split(separator: " ").map { Int64($0)! }

let calculator = PairMaxSum(n: n, m: m, d: d, groupA: groupA, groupB: groupB)

print(calculator.getSum())
