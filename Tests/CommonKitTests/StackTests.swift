//
//  StackTests.swift
//  
//
//  Created by Anton Pomozov on 19.07.2021.
//

import XCTest
@testable import CommonKit

final class StackTests: XCTestCase {
    override func setUp() {
        super.setUp()
        stack = Stack<Int>()
    }

    func testStack() {
        stack.push(10)
        XCTAssert(stack.count == 1, "Invalid count")
        XCTAssert(stack.top == 10, "Invalid top value")
        XCTAssert(!stack.isEmpty, "Is empty")

        stack.push(20)
        XCTAssert(stack.count == 2, "Invalid count")
        XCTAssert(stack.top == 20, "Invalid top value")
        XCTAssert(!stack.isEmpty, "Is empty")

        stack.push(30)
        XCTAssert(stack.count == 3, "Invalid count")
        XCTAssert(stack.top == 30, "Invalid top value")
        XCTAssert(!stack.isEmpty, "Is empty")

        XCTAssert(stack.pop() == 30, "Invalid value popped")
        XCTAssert(stack.top == 20, "Invalid top value")
        XCTAssert(!stack.isEmpty, "Is empty")

        XCTAssert(stack.pop() == 20, "Invalid value popped")
        XCTAssert(stack.top == 10, "Invalid top value")
        XCTAssert(!stack.isEmpty, "Is empty")

        stack.push(50)
        XCTAssert(stack.count == 2, "Invalid count")
        XCTAssert(stack.top == 50, "Invalid top value")
        XCTAssert(!stack.isEmpty, "Is empty")

        XCTAssert(stack.pop() == 50, "Invalid value popped")
        XCTAssert(stack.top == 10, "Invalid top value")
        XCTAssert(!stack.isEmpty, "Is empty")

        XCTAssert(stack.pop() == 10, "Invalid value popped")
        XCTAssert(stack.top == nil, "Invalid top value")
        XCTAssert(stack.isEmpty, "Is not empty")

        XCTAssert(stack.pop() == nil, "Invalid value popped")
        XCTAssert(stack.isEmpty, "Is not empty")
        XCTAssert(stack.pop() == nil, "Invalid value popped")
        XCTAssert(stack.isEmpty, "Is not empty")
    }

    func testStackRemoveAll() {
        stack.push(10)
        stack.push(20)
        stack.push(30)
        stack.removeAll()

        XCTAssert(stack.isEmpty, "Is not empty")
    }

    private var stack: Stack<Int>!
}

private extension StackTests {}
