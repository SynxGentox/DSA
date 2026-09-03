// The standard solution would be to iterate through whole array of string ans sort each string before comparing all string that will be O(m*nlogn) in time complexity.

// MARK: - Constrain irrelevant General solution.
// FreqMap Solution
/// TIme Complexity: O(n*m), Space Complexity: O(n*m)
/// this solution is slowest for small inputs but as input grows the freqMap size becomes constant. so as input grows it performs better but even at best case its somewhat similar to Sorting Solution with same input bcz even with less Time Complexity in O-term this solution has way to many constants which makes overall exectution time multiple times slower than Sorting Solution
class Solution {
    func groupAnagrams(_ strs: [String]) -> [[String]] {
        var result: [[Character: Int]: [String]] = [:]
        var freqMap: [Character: Int] = [:]
        
        // Time complexity for looping through collection of string: O(n)
        for (i, str) in strs.enumerated() {
            
            // Time complexity for looping through each string O(m)
            for char in str {
                // Time complexity of value increment: Amortized O(1)
                freqMap[char, default: 0] += 1
            }
            
            // append Time Complexity: O(1)
            result[freqMap, default: []].append(str)
            // removeAll Time Complexity: O(k) where k is count of element in colleciton. To prevent memory leak swift walk through each element zeroing out the ARC for every single operation even while keeping empty blocks alive (.removeAll(keepingCapacity: true))
            // in this specific case since key is value type, its better to use = [:]
            freqMap = [:]
        }
        return Array(result.values)
    }
}


// MARK: - Constrain irrelevant but only for Language and case specific solution.
/// Array character mapping Solution.
/// Time Complexity: O(n*m), Space Complexity: O(n*m)
/// This solution uses Array which maps character count on the index using the ascii code calculation as index in array. This solution performs better than Freq map but still slower than sorting solution and its language and case specific. Infact it can become the worst possible solution if made general for any laguage or type of string input and case.
// Its slower than Sort Method and faster than Dict-Key method bcz here we are using Array of Int as key which is lighter than Dict- as key but slower than String as key which makes difference in CPU Cycles. 

class Solution2 {
    func groupAnagrams(_ strs: [String]) -> [[String]] {
        var result: [[Int]: [String]] = [:]
        
        for (i, str) in strs.enumerated() {
            var freqMap = Array(repeating: 0, count: 26)
            
            for charAsc in str.utf8 {
                freqMap[Int(charAsc) - 97] += 1
            }
            
            // append Time Complexity: O(1)
            result[freqMap, default: []].append(str)
            freqMap = []
        }
        return Array(result.values)
    }
}

// MARK: - Constrain irrelevant general solution.
// Sorting Algo. Solution
/// TIme Complexity: O(n*mlogm), Space Complexity: O(n*m)

// This is the fastest in exectution time bcz even though it has higher Time Complexity it still exectutes faster bcz of less overhead load. In this we are using String as key which is faster than both Array as key and Dict/HashMap as key.
class Solution3 {
    func groupAnagrams(_ strs: [String]) -> [[String]] {
        var groups: [String: [String]] = [:]
        for str in strs {
            let key = String(str.sorted())
            groups[key, default: []].append(str)
        }
        return Array(groups.values)
    }
}
