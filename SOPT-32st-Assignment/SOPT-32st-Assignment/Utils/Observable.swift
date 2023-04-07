//
//  Observable.swift
//  SOPT-32st-Assignment
//
//  Created by 김민재 on 2023/04/07.
//

import Foundation


final class Observable<T> {

    struct Observer<T> {
        weak var observer: AnyObject? // Observer
        let block: (T) -> Void // Observer가 subscribe하면서 등록한 작업
    }

    // Observable은 Observers들을 가지고 있다.
    private var observers: [Observer<T>] = []

    var value: T {
        didSet {
            notifyObservers() // value가 바뀌면 Observers들에게 전체 알림
        }
    }

    init(_ value: T) {
        self.value = value
    }

    private func notifyObservers() {
        observers.forEach { // observers 배열을 돌며 등록한 작업 수행
            $0.block(value)
        }
    }

    func subscribe(on observer: AnyObject, block: @escaping (T) -> Void) {
        // Observers배열에 observer 작업과 함께 추가하고
        observers.append(
            Observer(observer: observer, block: block)
        )
        // 작업 수행
        block(value)
    }

    func remove(observer: AnyObject) {
        observers = observers.filter({
            $0.observer !== observer
        })
    }
}
