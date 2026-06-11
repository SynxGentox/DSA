//
//  C_Almost Equal.swift
//  
//
//  Created by Aryan Verma on 11/06/26.
//

import Foundation

class FindChain {
    let n: Int
    let m: Int
    let strings: [[Character]]
    
    init(n: Int, m: Int, strings: [[Character]]) {
        self.n = n
        self.m = m
        self.strings = strings
    }
    
    func isOffByOne(_ str1: [Character], _ str2: [Character]) -> Bool {
        var mismatch = 0
        for i in 0..<m {
            if str1[i] != str2[i] {
                mismatch += 1
            }
        }
        return mismatch == 1
    }
    
    func checker() {
        var visited = [Bool](repeating: false, count: n)
        
        func dfs(currentIndex: Int, chainLength: Int) -> Bool {
            if chainLength == n {
                return true
            }
            
            for nextIndex in 0..<n {
                if !visited[nextIndex] && isOffByOne(strings[currentIndex], strings[nextIndex]) {
                    
                    visited[nextIndex] = true
                    
                    if dfs(currentIndex: nextIndex, chainLength: chainLength + 1) {
                        return true
                    }
                    
                    visited[nextIndex] = false
                }
            }
            
            return false
        }
        
        for i in 0..<n {
            visited[i] = true
            
            if dfs(currentIndex: i, chainLength: 1) {
                print("Yes")
                return
            }
            
            visited[i] = false
        }
        
        print("No")
    }
}

if let firstLine = readLine() {
    let dimensions = firstLine.split(separator: " ")
    if let nValue = Int(dimensions[0]), let mValue = Int(dimensions[1]) {
        
        var inputGrid: [[Character]] = []
        for _ in 0..<nValue {
            if let rowString = readLine() {
                let cleanRow = rowString.trimmingCharacters(in: .whitespacesAndNewlines)
                inputGrid.append(Array(cleanRow))
            }
        }
        
        let program = FindChain(n: nValue, m: mValue, strings: inputGrid)
        program.checker()
    }
}
