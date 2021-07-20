//
//  Stack.swift
//  
//
//  Created by Anton Pomozov on 19.07.2021.
//

import Foundation

public struct Stack<T> {
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

    public mutating func push(_ value: T) { stack.append(value) }

    public mutating func pop() -> T? { stack.isEmpty ? nil : stack.removeLast() }

    public mutating func removeAll() { stack.removeAll() }

    private var stack: [T] = []
}
