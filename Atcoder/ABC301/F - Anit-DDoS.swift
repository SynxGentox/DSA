//
//  F_Anit-DDoS.swift
//  
//
//  Created by Aryan Verma on 09/06/26.
//

import Foundation

func solve() {
    let MOD: Int64 = 998244353
    
    guard let input = readLine()?.trimmingCharacters(in: .whitespacesAndNewlines) else { return }
    let s = Array(input)
    
    func modPow(_ base: Int64, _ exp: Int64) -> Int64 {
        var res: Int64 = 1
        var b = base % MOD
        var e = exp
        while e > 0 {
            if (e & 1) == 1 {
                res = (res * b) % MOD
            }
            b = (b * b) % MOD
            e >>= 1
        }
        return res
    }
    
    var inv = [Int64](repeating: 0, count: 27)
    for i in 1...26 {
        inv[i] = modPow(Int64(i), MOD - 2)
    }
    
    var a = [Int64](repeating: 0, count: 27)
    a[0] = 1
    
    var b: Int64 = 0
    var c: Int64 = 0
    
    var seen = [Bool](repeating: false, count: 26)
    var fixed = 0
    
    let uppercaseA = Character("A").unicodeScalars.first!.value
    let lowercaseA = Character("a").unicodeScalars.first!.value
    let lowercaseZ = Character("z").unicodeScalars.first!.value
    
    for ch in s {
        var next_a = [Int64](repeating: 0, count: 27)
        var next_b: Int64 = 0
        var next_c: Int64 = 0
        
        if ch == "?" {
            for y in 0...26 {
                let v = a[y]
                if v == 0 { continue }
                
                next_a[y] = (next_a[y] + 26 * v) % MOD
                next_b = (next_b + Int64(y) * v) % MOD
                
                if y < 26 {
                    next_a[y + 1] = (next_a[y + 1] + Int64(26 - y) * v) % MOD
                }
            }
            next_b = (next_b + 26 * b) % MOD
            next_c = (next_c + 26 * b + 26 * c) % MOD
            
        } else if let scalar = ch.unicodeScalars.first?.value, scalar >= lowercaseA && scalar <= lowercaseZ {
            next_a = a
            next_c = (b + c) % MOD
            
        } else {
            let id = Int(ch.unicodeScalars.first!.value - uppercaseA)
            
            if seen[id] {
                for y in 0...26 {
                    next_b = (next_b + a[y]) % MOD
                }
                next_b = (next_b + b) % MOD
            } else {
                let rest = 26 - fixed
                let inv_rest = inv[rest]
                
                for y in 0...26 {
                    let v = a[y]
                    if v == 0 { continue }
                    
                    let diff = Int64(y - fixed)
                    var used = (diff * inv_rest) % MOD
                    if used < 0 { used += MOD }
                    
                    let unused = (Int64(26 - y) * inv_rest) % MOD
                    
                    next_b = (next_b + v * used) % MOD
                    if y < 26 {
                        next_a[y + 1] = (next_a[y + 1] + v * unused) % MOD
                    }
                }
                next_b = (next_b + b) % MOD
                seen[id] = true
                fixed += 1
            }
        }
        
        a = next_a
        b = next_b
        c = next_c
    }
    
    var ans = (b + c) % MOD
    for v in a {
        ans = (ans + v) % MOD
    }
    
    print(ans)
}

solve()
