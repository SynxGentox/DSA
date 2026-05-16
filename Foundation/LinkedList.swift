//
//  LinkedList.swift
//  
//
//  Created by Aryan Verma on 16/05/26.
//

import Foundation

public class LLNode<T> {
    var value: T
    var nextNode: LLNode?
    var previousNode: LLNode?
    
    public init(value: T) {
        self.value = value
    }
}

public class LinkedList<T> {
    public typealias Node = LLNode<T>?
    
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
        } else {
            print("LinkedList is empty. Appending new Node ")
            head = newNode
        }
    }
    
    public var count: Int {
        guard var node = head else {
            return 0
        }
        var count = 1
        while let next = node.next {
            node = next
            count += 1
        }
        return count
    }
    
    
    public func item(atIndex index: Int?) -> [Node]? {
        var listArray: [Node] = []
        guard var node = head else {
            return nil
        }
        if index == nil {
            while var next = node?.next {
                listArray.append(node!)
                node = next
            }
            return listArray
        } else {
            guard index != 0 else {
                return Array(head!)
            }
            var node = head?.next
            for _ in 0..<index {
                node = node?.next
                if node == nil { break }
            }
            listArray = Array(node)
            return listArray
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
list.append(value: "data1")


