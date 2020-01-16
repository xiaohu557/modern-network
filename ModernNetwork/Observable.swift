//
//  Observable.swift
//  ModernNetwork
//
//  Created by Xi Chen on 16.01.20.
//  Copyright © 2020 Xi Chen. All rights reserved.
//

import Foundation

/**
 A simple observable implementation. It's similar to the 'BehaviorRelay' concept in RxSwift.
 */
public class Observable<T> {
    public typealias Observer = (T) -> Void
    private var observers: [UUID: Observer] = [:]

    public init(_ value: T) {
        self.value = value
    }

    @discardableResult
    public func bind(andFire fire: Bool = true,
                     observer: @escaping Observer) -> Disposable {
        let id = UUID()

        let disp = Disposable(uuid: id) { [weak self] in
            self?.observers[id] = nil
        }
        observers[id] = observer

        if fire {
            observer(value)
        }

        return disp
    }

    public func disposeAll() {
        observers = [:]
    }

    public func accept(_ value: T) {
        self.value = value
    }

    private(set) open var value: T {
        didSet {
            observers.forEach { $0.value(value) }
        }
    }
}

public protocol DisposableType {
    func dispose()
}

public class Disposable: DisposableType {
    private let _dispose: () -> Void
    private let uuid: UUID

    fileprivate init(uuid: UUID, dispose: @escaping () -> Void) {
        self.uuid = uuid
        self._dispose = dispose
    }

    public func dispose() {
        _dispose()
    }
}

