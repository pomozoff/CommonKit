//
//  AtomicTests.swift
//
//
//  Created by Anton Pomozov on 17.07.2021.
//

import XCTest
@testable import CommonKit

final class AtomicTests: XCTestCase {
    func testAtomic() {
        let storage = SharedStorage()

        for _ in 0 ..< 5 {
            DispatchQueue.global().async {
                for _ in 0 ..< 1_000 {
                    storage.counter[self.randomString(length: 5), default: 0] += 1
                }
            }
        }
    }
}

private extension AtomicTests {
    func randomString(length: Int) -> String {
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        return String((0 ..< length).map { _ in letters.randomElement()! })
    }
}

private class SharedStorage {
    @Atomic
    var counter: [String: Int] = [:]
}
