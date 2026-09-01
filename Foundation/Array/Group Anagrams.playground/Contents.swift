// The standard solution would be to iterate through whole array of string ans sort each string before comparing all string that will be O(m*nlogn) in time complexity.

//

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
            // removeAll Time Complexity: O(k) where k is count of element in colleciton. To prevent memory leak swift walk through each element zeroing out the ARC for every single operation even while keeping empty blocks alive
            freqMap.removeAll(keepingCapacity: true)
        }
        return Array(result.values)
    }
}
