// MARK: - Encoding and Decoding The String
// In this solution we used each String's length count + delimiter right after the count to keep track of the size as it the given string can hold anyhting at all.
/// we will do string.count + delimiter + string instead of delimiter after string, delimiter right after the count lets use know that "size(Int) which is in string format is counted and then we can porceed to count the string itself.

// Time Complexity: O(n), Space Complexity: O(1)
class Solution1 {
    func encode(_ strs: [String]) -> String {
        var encoded = ""
        
        // Iterating over string
        for str in strs {
            // Encoding the String as String length + delimiter + string.
            encoded += "\(str.count)$" + str
        }
        // return encoded string.
        return encoded
    }
    
    
    // Time Complexity: O(n), Space Complexity: O(n)
    func decode(_ strs: String) -> [String] {
        // Convert String to Array for O(1) lookups.
        let chars = Array(strs)
        var i = 0
        var result: [String] = []
        
        while i < chars.count {
            // new index to keep track of the length of full number
            var j = i
            
            // Loop until you completely iterate through the encoded number(string length)
            while chars[j].isNumber { j += 1 }
            
            // Converting the range of Characters to Int.
            let length = Int(String(chars[i..<j]))!
            // contentStart the starting index of actual string which is j + 1 bcz +1 ignore the delimiter we put right after length
            let contentStart = j + 1
            // end point of each string should be start +  length which correctly sums up to get the full string.
            let contentEnd = contentStart + length
            // Adding the identified string into the Array
            result.append(String(chars[contentStart..<contentEnd]))
            // changing the i to the first index of next string
            i = contentEnd
        }
        return result
    }
}


// MARK: - Directly reading string index to avoid heavy array memeory load.
// In this solution we used String.index instead of converting the string to character array.
// we achieve O(1) Auxilary space and avoid 16-byte Grapheme cluster memory bloat.
class Solution2 {
    // Time Complexity: O(n), Space Complexity: O(n)
    func encode(_ strs: [String]) -> String {
        // Reasoning: we are using array here bcz we pre-allocate the memory needed saving extra cpu cycles, while we can use reserveCapacity with strings too but we will need to input exact size of string and since each characters in swift can have size upto 16 bytes which makes it complicated, restrictive and stupid to do. which is why creating a character array
        var result = [String]()
        
        // Pre-allocate the array memory to prevent doubling overhead
        result.reserveCapacity(strs.count)
        
        for str in strs {
            // Reasoning: Using "  "(DefaultStringInterpolation) instead of Stirng(    ) type converstion as we are using delimiter with it which is a string/text.
            result.append("\(str.count)$\(str)")
        }
        
        // .joined() allocates the exact string size needed in one CPU cycle
        return result.joined()
    }
    
    // Time Complexity: O(n), Space Compelxity: O(1)
    func decode(_ s: String) -> [String] {
        var result: [String] = []
        
        // We are using String.Index to read the raw memory in-place instead of Arrays.
        /// A Character in swift is 16 Bytes and if the network payload is 10MB it takes 160MB immediately which is the heaviest way possible.
        /// Never convert the string to an array. Use Swift's native String.Index to slide a window across the raw string memory in-place.
        
        /// Working: Here i is currently pointing at the very first character's memory address.
        /// Note: Neither i nor j are Int, they are Memory Pointers...
        // Time Complexity: O(1), Space Complexity: O(1)
        var i = s.startIndex
        
        // Loop till we reach out memory pointer(i) reaches last string character.
        while i < s.endIndex {
            // New variable holding starting index pointer as we need to create a sliding window.
            var j = i
            
            // Move 'j' forward until we hit the delimiter.
            while s[j] != "$" {
                /// Working: .index(after: ) points at exactly the next character of the j, after: looks at the pointer's unicode value and jumps to next character's unicode value.
                // Time Complexity: O(1)
                j = s.index(after: j)
            }
            
            // Extract the length
            let length = Int(s[i..<j])!
            
            // Calculate the exact memory bounds of the actual string
            let contentStart = s.index(after: j)
            /// Working: .index(_, offsetBy: ) takes the Start.Index type value which represents where you wanna start the offset from, offsetBy is the distance of how many character after given index swift should jump.
            /// Working: Swift iterates the Start.Index to next character no matter the each character's buffer size and it will return the memory pointer of the character exactly after offset numbers of iteration.
            let contentEnd = s.index(contentStart, offsetBy: length)
                
            
            // Extract and append
            result.append(String(s[contentStart..<contentEnd]))
            
            // Jump 'i' forward to the start of the next payload
            i = contentEnd
        }
        
        return result
    }
}


