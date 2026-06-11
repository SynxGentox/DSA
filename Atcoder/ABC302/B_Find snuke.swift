//
//  B_Find snuke.swift
//  
//
//  Created by Aryan Verma on 11/06/26.
//

import Foundation

class FindSnuke {
    let h: Int
    let w: Int
    let grid: [[Character]]
    
    init(h: Int, w: Int, grid: [[Character]]) {
        self.h = h
        self.w = w
        self.grid = grid
    }
    
    func finder() {
        let target = Array("snuke")
        
        let directions = [
            (-1, 0),  (1, 0),  (0, -1), (0, 1),
            (-1, -1), (-1, 1), (1, -1), (1, 1)
        ]
        
        for r in 0..<h {
            for c in 0..<w {
                if grid[r][c] == "s" {
                    
                    for (dr, dc) in directions {
                        var matchFound = true
                        var pathCoordinates: [(Int, Int)] = []
                        
                        for i in 0..<5 {
                            let nextR = r + (i * dr)
                            let nextC = c + (i * dc)
                            
                            if nextR >= 0 && nextR < h && nextC >= 0 && nextC < w {
                                if grid[nextR][nextC] == target[i] {
                                    pathCoordinates.append((nextR + 1, nextC + 1))
                                } else {
                                    matchFound = false
                                    break
                                }
                            } else {
                                matchFound = false
                                break
                            }
                        }
                        
                        if matchFound {
                            for coord in pathCoordinates {
                                print("\(coord.0) \(coord.1)")
                            }
                            return
                        }
                    }
                }
            }
        }
    }
}

if let line = readLine() {
    let dimensions = line.split(separator: " ")
    if let h = Int(dimensions[0]), let w = Int(dimensions[1]) {
        var inputGrid: [[Character]] = []
        
        for _ in 0..<h {
            if let rowString = readLine() {
                inputGrid.append(Array(rowString.trimmingCharacters(in: .whitespacesAndNewlines)))
            }
        }
        
        let solver = FindSnuke(h: h, w: w, grid: inputGrid)
        solver.finder()
    }
}

