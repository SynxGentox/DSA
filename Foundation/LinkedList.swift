//
//  LinkedList.swift
//  
//
//  Created by Aryan Verma on 16/05/26.
//

import Foundation

public class LLNode<T> {
    var value: T
    var next: LLNode?
    var previous: LLNode?
    
    public init(value: T) {
        self.value = value
    }
}

public class LinkedList<T> {
    public typealias Node = LLNode<T>
    
    private var head: Node?
    public var first: Node? {
        return head
    }
    
    public var last: Node? {
        guard var node = head else {
            return nil
        }
        while let next = node.next {
            node = next
        }
        return node
    }
    
    public func append(value: T) {
        let newNode = Node(value: value)
        if let lastNode = last {
            lastNode.next = newNode
            newNode.previous = lastNode
            print("New node added: \(value)")
        } else {
            head = newNode
            print("New node added in empty LinkedList: \(value)")
        }
    }
    
    public var count: Int {
        guard var node = head else {
            print(0)
            return 0
        }
        var count = 1
        while let next = node.next {
            node = next
            count += 1
        }
        print(count)
        return count
    }
    
    public func insert(value: T, at index: Int) {
        print("value: \(value) is inserted at index: \(index)")
        guard let node = head else {
            head = Node(value: value)
            return
        }
        let newNode = Node(value: value)
        if index == 0 {
            newNode.next = head
            head?.previous = newNode
            head = newNode
        } else {
            let previousNode = getItem(at: index - 1)
            let nextNode = previousNode?.next
            previousNode!.next = newNode
            newNode.previous = previousNode
            newNode.next = nextNode
            nextNode?.previous = newNode
        }
    }
    
    public func remove(at index: Int) {
        guard let node = head else {
            print("LinkedList is empty")
            return
        }
        var removeNode = getItem(at: index)
        if removeNode == nil {
            print("Index doesnt exists")
            return
        } else {
            let prevNode = removeNode?.previous
            let nextNode = removeNode?.next

            if prevNode == nil {
                head = nextNode
                nextNode?.previous = nil
            } else {
                prevNode?.next = nextNode
                nextNode?.previous = prevNode
            }
        }
    }
    
    
    public func getItem(at index: Int?) -> Node? {
        var stringArray: String = "["
        guard var node = head else {
            stringArray + "]"
            print(stringArray)
            return nil
        }
        if index == nil {
            while let next = node.next {
                stringArray = stringArray + "\(node.value), "
                node = next
            }
            stringArray = stringArray + "\(node.value) ]"
            print(stringArray)
            return nil
        } else {
            guard index != 0 else {
                stringArray = stringArray + "\(head!.value)]"
                print(stringArray)
                return head!
            }
            var node = node.next
            for _ in 1..<index! {
//                guard let nextNode = node?.next else{ break }
//                node = nextNode
                node = node?.next
                if node == nil { break }
            }
            stringArray = stringArray + "\(node!.value)]"
            print(stringArray)
            return node!
        }
    }
   
//    public func node(atIndex index: Int) -> Node {
//        if index == 0 {
//            return head!
//        } else {
//            var node = head?.next
//            for _ in 1..<index {
//                node = node?.next
//                if node == nil { break }
//            }
//            return node!
//        }
//    }
    
}

let list = LinkedList<String>()
list.first
list.last
list.append(value: "data2")
list.append(value: "data3")
list.append(value: "data4")
list.append(value: "data5")
list.getItem(at: nil)
list.insert(value: "data6", at: 1)
list.getItem(at: nil)
list.remove(at: 1)
list.getItem(at: nil)


