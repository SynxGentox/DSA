//
//  B - Discord.swift
//
//
//  Created by Aryan Verma on 21/08/26.
//

import Foundation

struct Pairs: Hashable {
    var x: Int
    var y: Int
    
    init(_ x: Int, _ y: Int) {
        self.x = min(x,y)
        self.y = max(x,y)
    }
}

struct Discord {
    var n: Int
    var m: Int
    var album: [[Int]]
    
    func unhappyPairs() {
        var happyPairs: Set<Pairs> = []
        
        for photo in album {
            for j in 0..<(n-1) {
                    happyPairs.insert(Pairs(photo[j], photo[j+1]))
            }
        }
        let totalPairs = (n*(n-1))/2
        let unhappyPairs = totalPairs - happyPairs.count
        
        print(unhappyPairs)
    }
}

let firstLine = readLine()!.split(separator: " ").map { Int($0)! }
let n = firstLine[0]
let m = firstLine[1]

var album: [[Int]] = []

for _ in 0..<m {
    let photoLine = readLine()!.split(separator: " ").map { Int($0)! }
    album.append(photoLine)
}

let tracker = Discord(n: n, m: m, album: album)
tracker.unhappyPairs()
