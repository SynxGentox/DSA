//
//  C - Dash.swift
//  
//
//  Created by Aryan Verma on 24/08/26.
//

import Foundation

struct Point: Hashable {
    var x: Int
    var y: Int
}

struct Dash {
    var n: Int
    var m: Int
    var h: Int
    var k: Int
    
    var moves: String
    var items: Set<Point>
    
    mutating func canComplete() {
        var current = Point(x: 0, y: 0)
        
        for move in moves {
            h -= 1
            switch move {
                case "R": current.x += 1
                case "L": current.x -= 1
                case "U": current.y += 1
                case "D": current.y -= 1
                default: break
            }
            if h < 0 {
                print("No")
                return
            }
            if h < k {
                if items.contains(current) {
                    h = k
                    items.remove(current)
                }
            }
            
        }
        print("Yes")
    }
}

if let firstLine = readLine() {
    let parts = firstLine.split(separator: " ").map { Int($0)! }
    let n = parts[0]
    let m = parts[1]
    let h = parts[2]
    let k = parts[3]
    
    let moves = readLine()!
    
    var items = Set<Point>()
    
    for _ in 0..<m {
        let coords = readLine()!.split(separator: " ").map { Int($0)! }
        items.insert(Point(x: coords[0], y: coords[1]))
    }
    
    var game = Dash(n: n, m: m, h: h, k: k, moves: moves, items: items)
    game.canComplete()
}
