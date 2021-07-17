import XCTest
@testable import CommonKit

final class CommonKitTests: XCTestCase {
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

private extension CommonKitTests {
    func randomString(length: Int) -> String {
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        return String((0 ..< length).map { _ in letters.randomElement()! })
    }
}

private class SharedStorage {
    @Atomic
    var counter: [String: Int] = [:]
}
