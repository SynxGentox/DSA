//
//  B_Same Map in the RPG World.swift
//  
//
//  Created by Aryan Verma on 16/05/26.
//

import Foundation

class Map {
    var map1: [[Character]] = []
    var map2: [[Character]] = []
    
    func checkElements(s: Int, t: Int) -> Bool {
        for i in 0..<map1.count {
            for j in 0..<map1[0].count {
                if map1[(i + s) % map1.count][(j + t) % map1[0].count] != map2[i][j] {
                    return false
                }
            }
        }
        return true
    }
    
    func main() {
        outer: for s in 0..<map1.count {
            for t in 0..<map1[0].count {
                if checkElements(s: s, t: t) {
                    print("Yes")
                    break outer
                }
            }
            if s == map1.count - 1 {
                print("No")
            }
        }
    }
}

let hw = readLine()!.split(separator: " ").map { Int($0)! }
let h = hw[0], w = hw[1]

let m = Map()
for _ in 0..<h { m.map1.append(Array(readLine()!)) }
for _ in 0..<h { m.map2.append(Array(readLine()!)) }
m.main()
