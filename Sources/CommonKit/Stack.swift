//
//  Stack.swift
//  
//
//  Created by Anton Pomozov on 19.07.2021.
//

import Foundation

public struct Stack<T: Equatable> {
    public var top: T? { stack.last }

    public var count: Int { stack.count }

    public var isEmpty: Bool { stack.isEmpty }

    public init() {}

    public func last(where closure: (T) -> Bool) -> T? {
        for value in stack.reversed() {
            if closure(value) { return value }
        }
        return nil
    }

    public func contains(_ element: T) -> Bool {
        stack.contains(element)
    }

    public func contains(where closure: (T) -> Bool) -> Bool {
        stack.contains(where: closure)
    }

    public mutating func reversed() -> Stack<T> {
        var stack = Stack<T>()
        while let element = pop() { stack.push(element) }
        return stack
    }

    public mutating func push(_ value: T) { stack.append(value) }

    public mutating func pop() -> T? { stack.isEmpty ? nil : stack.removeLast() }

    public mutating func removeAll() { stack.removeAll() }

    private var stack: [T] = []
}
