//
//  Observable.swift
//  MovieList
//
//  Created by 강건 on 2021/10/26.
//

import Foundation

//    MARK: - ViewModel 에서 사용하는 Observable class
final class Observable<T> {
    //    모든 Observable 은 값이 변경되었을 때 통지해 주는 Listener를 갖는다.
    typealias Listener = (T) -> Void
    var listener: Listener?
    //    didSet 속성 관찰자는 모든 변경 사항을 감지하고 Listner에게 값 업데이트를 알린다.
    var value: T {
        didSet {
            listener?(value)
        }
    }
    //    Initializer는 Observable의 초기값을 설정한다.
    init(_ value: T) {
        self.value = value
    }
    //    Listner가 bind를 호출하면 이것은 즉시 Listner가 되고 Observable의 현재값을 즉시 알려준다.
    func bind(listener: Listener?) {
        self.listener = listener
        listener?(value)
    }
}
