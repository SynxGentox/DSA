//
//  A_Overall Winner.swift
//  
//
//  Created by Aryan Verma on 30/05/26.
//d

import Foundation

class GameWinner {
    let n: Int
    let s: [Character]
    
    init(n: Int, s: String) {
        self.n = n
        self.s = Array(s)
    }
    
    func winner() {
        var countTWins = 0
        var countAWins = 0
        
        for char in s {
            if char == "T" {
                countTWins += 1
                continue
            }
            countAWins += 1
        }
        
        if countTWins == countAWins {
            if s[s.count - 1] == "T" {
                print("A")
                return
            }
            print("T")
            return
        }
        
        if countTWins > countAWins {
            print("T")
            return
        } else {
            print("A")
            return
        }
    }
}

if let firstLine = readLine(), let n = Int(firstLine) {
    
    if let s = readLine() {
        let solver = GameWinner(n: n, s: s)
        solver.winner()
    }
}
