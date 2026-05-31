//
//  C_Atcoder Card Game.swift
//  
//
//  Created by Aryan Verma on 31/05/26.
//

import Foundation

class AtcoderCards {
    let s: String
    let t: String
    
    init(s: String, t: String) {
        self.s = s
        self.t = t
    }
    
    func checkWin() {
        let atcoderSet: Set<Character> = ["a", "t", "c", "o", "d", "e", "r"]
        
        var tCounts:  [Character: Int] = [:]
        for char in t { tCounts[char, default: 0] += 1 }
        
        var sWildcards = 0
        
        for char in s {
            if char == "@" {
                sWildcards += 1
                continue
            }
            let availableInT = tCounts[char, default: 0]
            if availableInT > 0 {
                tCounts[char] = availableInT - 1
                continue
            }
            
            if !atcoderSet.contains(char) {
                print("No")
                return
            }
            let tWildcards = tCounts["@", default: 0]
            if tWildcards > 0 {
                tCounts["@"] = tWildcards - 1
            }
            else {
                print("No")
                return
            }
        }
        
        for (char, count) in tCounts {
            if char == "@" { continue }
            if count > 0 {
                if !atcoderSet.contains(char) {
                    print("No")
                    return
                }
                sWildcards -= count
                if sWildcards < 0 {
                    print("No")
                    return
                }
            }
        }
        print("Yes")
    }
}

if let s = readLine(), let t = readLine() {
    let solver = AtcoderCards(s: s, t: t)
    solver.checkWin()
}
