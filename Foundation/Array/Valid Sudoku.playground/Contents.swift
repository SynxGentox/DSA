// MARK: - Hash-Set solution (Easiest Solution and quite Optimal)
// In this solution we are using HashMaps, where keys = index of Arrays and Sub-Arrays with values = Set of Elements at that index.
/// cols - contains all the elements that are present at index 0 through n. E.g. - All elements at index 0 of all rows
/// rows - contains all the elements that are present in each row. E.g. - All elements in a row
/// grid - contains all the elements that are present in each grid but here the index is (r/3) & (c/3). which represents the Grid Number like: all elements with or less index than (2, 2) will be present in grid number 0 as 2/3 = 0 in Int format. which gives us (0, 0) which represent the very first 3x3 grid and so on.

class Solution {
    func isValidSudoku(_ board: [[Character]]) -> Bool {
        var rows: [Int: Set<Character>] = [:]
        var cols: [Int: Set<Character>] = [:]
        var grid: [[Int]: Set<Character>] = [:]
        
        for c in 0..<board.count {
            for r in 0..<board[0].count {
                var currEle = board[r][c]   // current Element
                
                if board[r][c] == "." {
                    continue
                }
                
                var cellNo = [r/3, c/3]    // current sub-grid Number
                
                // Checking for dublicates
                if rows[r, default: []].contains(currEle) ||
                    cols[c, default: []].contains(currEle) ||
                    grid[cellNo, default: []].contains(currEle) {
                    return false
                }
                // If not Present then inserting elements in the Sets.
                rows[r, default: []].insert(currEle)
                cols[c, default: []].insert(currEle)
                grid[cellNo, default: []].insert(currEle)
            }
        }
        return true
    }
}


