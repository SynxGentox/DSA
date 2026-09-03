//
//  Bucket Sort.swift
//  
//
//  Created by Aryan Verma on 04/09/26.
//

// MARK: -  Bucket Sort
- Its a sorting algorithm which stores element in n(n = number of elements) Buckets(Nested Arrays) according to the element itself and then flatens the array to get a sorted output.

    // MARK: - Basic Sorting.
        - Example: [3,2,6,7,1,0,4,1], n = 8
            // There are 10 Buckets as out lowest number is 0 and highest is 7 which are 8 in number that makes 8 Buckets.
            // In this case will create Int Type Buckets [[Int]], here [Int] are the Buckets.
            /// Iterating over this array...
            /// Index of array:      0    1    2    3   4    5    6    7
                                |   |   |   |   |   |   |   |   |
                                |   | 1 |   |   |   |   |   |   |
                                | 0 | 1 | 2 | 3 | 4 |   | 6 | 7 |
            // now we will Flaten the Buckets
                                [0, 1, 1, 2, 3, 4, 6, 7]    // here is our sorted array.


    // MARK: - Using Bucket Formula
        // But what if we have array which have Millions of elements or with very Large Numbers as element like 1000 as an element.
        - In this case we cant create buckets normally otherwise we would be using too much space and time.
        - To solve this we can use some formula

        let maxElement = 100
        let n = nums.count
        
        // Cast to Double to prevent integer truncation (e.g., 83 / 101 yielding 0)
        let normalization = Double(num) / Double(maxElement + 1)
            /// where 'num' is the current number, max is the larget number in the bucket.            ...This gives approx value...
        let bucketNo = Int(Double(n) * normalization)
            /// where 'n' is count of elements in array.                                ...This gives Bucket No for each element...

        /// using this formaula we will get the bucket no for the elements in our array.

        - Example: [83, 12, 2, 9, 78, 100, 99, 33], n = 8
            // Create Total n number of buckets.

            /// Using formula to get bucketNo of each element.
                e.g. -  index = 0, array[i] = 83, max element = 100(fixed as its the largest)
                        normalization = 83/(100 + 1) = 0.82
                        buckNo = Int(8 * 0.82) = Int(6.56) = 6
                // add element to in the calculated BucketNo.
            /// Iterating over this array...
            /// Index of array:      0      1     2     3     4     5     6     7
                                |  9 |    |    |    |    |    |    |     |
                                |  2 |    |    |    |    |    | 78 |  99 |
                                | 12 |    | 33 |    |    |    | 83 | 100 |

            // Iterating over the array scatter-gathers elements into buckets:
            // Bucket 0: [12, 2, 9]   (un-sorted arrival order)
            // Bucket 4: [33]
            // Bucket 6: [83, 78]   (un-sorted arrival order)
            // Bucket 7: [100, 99]
            
            // Step: Sort each non-empty bucket individually (typically using Insertion Sort)
            /// Using Insertion sort is actually better than using it to sort the whole bcz here we are giving the insertion sort optimal cases so it will perform better.

            for i in 0..<buckets.count {
                buckets[i].sort() // Or custom insertionSort(&buckets[i])
            }
            
            // Sorted Buckets: [[2, 9, 12], [33], [78, 83], [99, 100]]
            // Flatten: [2, 9, 12, 33, 78, 83, 99, 100]

    // MARK: - Using Bucket Sort with Frequency Map to get sorted repetition count.
        // Using Bucket Sort can also be used to get the array of most repeated elements in increasing or decreasing order.
        - We can use the Frequencies from FreqMap as bucket number.
    
        - Example: -
            let FreqMap = [83: 2, 1: 3, 33: 2, 87: 1], n = 4
            // now we will create Buckets Array [[Int]].

            var buckets: [[Int]] = Array(repeating: [], count: n + 1)   // n + 1, so we dont have to do - 1 on each step, we can directly append by skipping.
            // now add elements at the index which would be their repetition count.
            
            /// Iterating over this array...
            /// Index of array:      0     1     2    3    4
                                |   |    |    |   |   |
                                |   |    | 33 |   |   |
                                |   | 87 | 83 | 1 |   |

            // NOTE: - Frequency Bucketing Note
            // Elements with equal frequencies (e.g., 83 and 33 both appearing twice) end up in the same bucket.
            
            // Flattening preserves insertion order unless an additional sorting step is applied:
                                [87, 83, 33, 1]    // now if you notice we actually have the sorted array but according to repetition count.
                                                   // we can read if from 0 to n for increasing count or n to 0 for decreasing count.
                    
