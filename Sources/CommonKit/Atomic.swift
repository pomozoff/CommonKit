//
//  Atomic.swift
//  
//
//  Created by Anton Pomozov on 17.07.2021.
//

import Foundation

@propertyWrapper
public class Atomic<Value> {
    public var projectedValue: Atomic<Value> { self }

    public init(wrappedValue: Value) {
        value = wrappedValue
    }

    public var wrappedValue: Value {
        get {
            defer { lock.unlock() }
            lock.rlock()

            return value
        }
        set {
            defer { lock.unlock() }
            lock.wlock()

            value = newValue
        }
    }

    public func mutate(_ mutation: (inout Value) -> Void) {
        defer { lock.unlock() }
        lock.wlock()

        mutation(&value)
    }

    private let lock = ReadWriteLock()
    private var value: Value
}

private final class ReadWriteLock {
    @inlinable
    func rlock() {
        pthread_rwlock_rdlock(&rwlock)
    }

    @inlinable
    func wlock() {
        pthread_rwlock_wrlock(&rwlock)
    }

    @inlinable
    func unlock() {
        pthread_rwlock_unlock(&rwlock)
    }

    private var rwlock: pthread_rwlock_t = {
        var rwlock = pthread_rwlock_t()
        pthread_rwlock_init(&rwlock, nil)
        return rwlock
    }()
}
