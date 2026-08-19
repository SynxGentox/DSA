//
//  E - Isolation.swift
//  
//
//  Created by Aryan Verma on 18/08/26.
//

import Foundation

struct Isolation {
    let n: Int
    let q: Int
    
    // Processes the queries
    func processQueries() {
        // Creating a graph to track the connections, we are using n+1 to avoid indexing complexity. e.g. Line 25 and 26 we had to do -1 to stay in indexing limit of array. n+1 avoids that problem.
        var graph = Array(repeating: Set<Int>(), count: n + 1)
        var isolationCount = n
        
        // loops through each query
        for _ in 0..<q {
            // reads queries from input
            let query = readLine()!.split(separator: " ").map { Int($0)! }
            let type = query[0]
            
            // Type 1 to connect
            if type == 1 {
                // initialzing query users as u and v
                let u = query[1]
                let v = query[2]
                
                // checking if user is isolated or not.
                if graph[v].isEmpty {
                    isolationCount -= 1
                }
                if graph[u].isEmpty {
                    isolationCount -= 1
                }
                
                // forming connection both ways
                graph[u].insert(v)
                graph[v].insert(u)
            }
            // Type 2 to isolate
            else if type == 2 {
                // Initializing the target user as v
                let v = query[1]
                
                // checking if user(graph Index) is already isolated or not.
                if !graph[v].isEmpty {
                    isolationCount += 1
                    
                    // Looping through each connection(index, since the connection is connected in both ways)
                    for member in graph[v] {
                        // visiting each conneciton and removing the targeted user.
                        graph[member].remove(v)
                        
                        // checking if the other user is isolated or not.
                        if graph[member].isEmpty {
                            isolationCount += 1
                        }
                    }
                }
                // removing all connection of targeted user.
                graph[v].removeAll()
            }
            // priniting the connections.
            print(isolationCount)
        }
    }
}

if let firstLine = readLine() {
    let parts = firstLine.split(separator: " ").map { Int($0)! }
    let n = parts[0]
    let q = parts[1]
    
    let tracker = Isolation(n: n, q: q)
    tracker.processQueries()
}
