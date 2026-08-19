//
//  A - SimilarString.swift
//  
//
//  Created by Aryan Verma on 19/08/26.
//

import Foundation

struct SimilarString {
    let n: Int
    let s: String
    let t: String
    
    func similarCharacters() {
        
        for (charS, charT) in zip(s, t) {
            
            switch (charS, charT) {
                case let (x, y) where x == y:
                    continue
                case ("1", "l"), ("l", "1"):
                    continue
                case ("0", "o"), ("o", "0"):
                    continue
                default:
                    print("No")
                    return
            }
        }
        print("Yes")
    }
}

let n = Int(readLine()!)!
let s = readLine()!
let t = readLine()!

let check = SimilarString(n: n, s: s, t: t)
check.similarCharacters()
