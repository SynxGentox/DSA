let line1 = readLine()!.split(separator: " ").map { Int($0)! }
let n = line1[0]
let a = line1[1]
let b = line1[2]

let c = readLine()!.split(separator: " ").map { Int($0)! }

let ans = a + b

for i in 0..<n {
    if ans == c[i] {
        print(i + 1)
        break
    }
}
