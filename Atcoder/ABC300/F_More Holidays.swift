//
//  F_More Holidays.swift
//  
//
//  Created by Aryan Verma on 30/05/26.
//

import Foundation

class MoreHolidays {
    let s: String
    let n: Int64
    let m: Int64
    let k: Int64
    
    var pref: [Int64] = []
    let totalXinS: Int64
    
    init(s: String, n: Int, m: Int, k: Int) {
        self.s = s
        self.n = Int64(n)
        self.m = Int64(m)
        self.k = Int64(k)
        
        var count: Int64 = 0
        pref.append(0)
        for char in s {
            if char == "x" { count += 1 }
            pref.append(count)
        }
        totalXinS = count
    }
    
    func furthestRight(target: Int64) -> Int {
        var low = 0
        var high = Int(n)
        var ans = 0
        while low <= high {
            let mid = (high + low) / 2
            if pref[mid] <= target {
                ans = mid
                low = mid + 1
            } else {
                high = mid - 1
            }
        }
        return ans
    }
    
    func maxLength() -> Int64 {
        var maxLen: Int64 = 0
        
        for i in 0..<Int(n) {
            let skippedX = pref[i]
            let totalX = k + skippedX
            
            if totalX < totalXinS {
                let largestIndex = furthestRight(target: totalX)
                let xLength = Int64(largestIndex - i)
                maxLen = max(maxLen, xLength)
                continue
            }
            
            let leftPartLen = n - Int64(i)
            let xCost = totalXinS - skippedX
            
            let remainingX = k - xCost
            let possibleMiddleBlocks = remainingX / totalXinS
            let actualMiddleBlocks = min(possibleMiddleBlocks, m - 1)
            
            let middlePartLen = actualMiddleBlocks * n
            let middleXCost = actualMiddleBlocks * totalXinS
            
            let remainingRightX = remainingX - middleXCost
            var rightPartLen: Int64 = 0
            if actualMiddleBlocks < m - 1 {
                rightPartLen = Int64(furthestRight(target: remainingRightX))
            }
            
            let currentTotalLen = leftPartLen + middlePartLen + rightPartLen
            maxLen = max(maxLen, currentTotalLen)
        }
        return maxLen
    }
}

if let line1 = readLine()?.split(separator: " "), line1.count >= 3 {
    let n = Int(line1[0])!
    let m = Int(line1[1])!
    let k = Int(line1[2])!
    if let s = readLine() {
        let solver = MoreHolidays(s: s, n: n, m: m, k: k)
        print(solver.maxLength())
    }
}
