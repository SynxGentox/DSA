//
//  D_AABCC.swift
//  
//
//  Created by Aryan Verma on 25/05/26.
//

import Foundation

class AABCC {
    let n: Int64
    var primes: [Int] = []
    
    init(n: Int64) {
        self.n = n
    }
    
    func generatePrime(upto limit: Int) {
        var isPrime = Array(repeating: true, count: limit + 1)
        isPrime[0] = false
        isPrime[1] = false
        
        for i in 2...limit {
            if isPrime[i] {
                primes.append(i)
                
                var multiple = i * i
                while multiple < limit {
                    isPrime[multiple] = false
                    multiple += i
                }
            }
        }
    }
    
    func maxCCount(for c: Int) -> Int{
        var low = 0
        var high = primes.count - 1
        var ans = -1
        
        while low <= high {
            let mid = (low + high)/2
            if c >= primes[mid] {
                ans = mid
                low = mid + 1
            } else {
                high = mid - 1
            }
        }
        return ans
    }
    
    func main() {
        var maxC = 300_000
        generatePrime(upto: maxC)
        var combinationCount = 0
        
        for i in 0..<primes.count {
            let a: Int64 = Int64(primes[i])
            // calculated max value of a using formula a^5 = 10^12 derived from a^2 x b x c^2 = 10^12 as a^5 = 10^12. we took a^2 x a x a^2 instead of a^2 x (a+1) x (a+2)^2 bcz the difference is almost none and 2nd increases complexity signigicantly
            if a > 251 {
                break
            }
            
            for j in (i+1)..<primes.count {
                let b: Int64 = Int64(primes[j])
                
                if Double(a * a) * Double(b) * Double(b * b) > Double(n) {
                    break
                }
                
                maxC = Int(sqrt(Double(n)/Double(a * a * b)))
                var countOfC = maxCCount(for: maxC)
                
                if countOfC > j {
                    combinationCount += countOfC - j
                }
            }
        }
        print(combinationCount)
    }
}

if let input = readLine(), let n = Int64(input) {
    let solver = AABCC(n: n)
    solver.main()
}
