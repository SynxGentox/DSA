//
//  E_Pac-Takahashi.swift
//  
//
//  Created by Aryan Verma on 04/06/26.
//

import Foundation

struct Coordinate {
    let r: Int
    let c: Int
}

class PacTakahashi {
    let h: Int
    let w: Int
    let t: Int
    let grid: [[Character]]
    
    init(h: Int, w: Int, t: Int, grid: [[Character]]) {
        self.h = h
        self.w = w
        self.t = t
        self.grid = grid
    }
    
    func pathFinder() {
        var startPos = Coordinate(r: 0, c: 0)
        var goalPos = Coordinate(r: 0, c: 0)
        var candyPos: [Coordinate] = []
        
        for r in 0..<h {
            for c in 0..<w {
                if grid[r][c] == "S" { startPos = Coordinate(r: r, c: c) }
                else if grid[r][c] == "G" { goalPos = Coordinate(r: r, c: c) }
                else if grid[r][c] == "o" { candyPos.append(Coordinate(r: r, c: c)) }
            }
        }
        
        let k = candyPos.count
        let nodes: [Coordinate] = [startPos] + candyPos + [goalPos]
        let totalNodes = nodes.count
        
        let INF = 1_00_000_000
        var dist: [[Int]] = Array(repeating: [Int](repeating: INF, count: totalNodes), count: totalNodes)
        
        let gr = [-1, 1, 0, 0]
        let gc = [0, 0, 1, -1]
        
        for i in 0..<totalNodes {
            let origin = nodes[i]
            var bfsDist: [[Int]] = Array(repeating: [Int](repeating: INF, count: w), count: h)
            var queue = [origin]
            var head = 0
            bfsDist[origin.r][origin.c] = 0
            
            while head < queue.count {
                let curr = queue[head]
                head += 1
                
                let currDist = bfsDist[curr.r][curr.c]
                
                for d in 0..<4 {
                    let nr = curr.r + gr[d]
                    let nc = curr.c + gc[d]
                    
                    if nr >= 0 && nr < h && nc >= 0 && nc < w && grid[nr][nc] != "#" {
                        if bfsDist[nr][nc] == INF {
                            bfsDist[nr][nc] = currDist + 1
                            queue.append(Coordinate(r: nr, c: nc))
                        }
                    }
                }
            }
            
            for j in 0..<totalNodes {
                let dest = nodes[j]
                dist[i][j] = bfsDist[dest.r][dest.c]
            }
        }
        
        if dist[0][totalNodes - 1] == INF {
            print("-1")
            return
        }
        
        if k == 0 {
            if dist[0][totalNodes - 1] <= t {
                print("0")
            } else {
                print("-1")
            }
            return
        }
        
        let maxMask = 1 << k
        var dp = [[Int]](repeating: [Int](repeating: INF, count: totalNodes), count: maxMask)
        dp[0][0] = 0
        
        for mask in 0..<maxMask {
            for u in 0..<totalNodes {
                if dp[mask][u] == INF { continue }
                
                for v in 1...k {
                    let candyBit = v - 1
                    if (mask & (1 << candyBit)) == 0 {
                        let nextMask = mask | (1 << candyBit)
                        let stepCost = dist[u][v]
                        if dp[mask][u] + stepCost < dp[nextMask][v] {
                            dp[nextMask][v] = dp[mask][u] + stepCost
                        }
                    }
                }
            }
        }
        
        var maxCandiesCollected = -1
        
        for mask in 0..<maxMask {
            for u in 0..<totalNodes {
                if dp[mask][u] == INF { continue }
                
                let totalTripCost = dp[mask][u] + dist[u][totalNodes - 1]
                if totalTripCost <= t {
                    let candyCount = mask.nonzeroBitCount
                    if candyCount > maxCandiesCollected {
                        maxCandiesCollected = candyCount
                    }
                }
            }
        }
        
        print(maxCandiesCollected)
    }
}

if let firstLineStr = readLine() {
    let firstLine = firstLineStr.split(separator: " ").map { Int($0)! }
    let h = firstLine[0]
    let w = firstLine[1]
    let t = firstLine[2]

    var grid: [[Character]] = []
    for _ in 0..<h {
        if let line = readLine() {
            grid.append(Array(line))
        }
    }

    let solver = PacTakahashi(h: h, w: w, t: t, grid: grid)
    solver.pathFinder()
}
