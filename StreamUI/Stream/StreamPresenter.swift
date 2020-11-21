//
//  StreamPresenter.swift
//  StreamUI
//
//  Created by hikaruhara on 2020/11/20.
//

import Foundation
import RxSwift

final class StreamPresenter {
    private let interactor: StreamInteractor = .init()
    private let disposeBag: DisposeBag = .init()
    weak var view: StreamView!
    
    init(view: StreamView) {
        self.view = view
    }
    
    func didLoad() {
        interactor.getMessages().subscribe(onNext: { string in
            self.view.update(string)
        }).disposed(by: disposeBag)
    }
}

final class StreamInteractor {
    func getMessages() -> Observable<String> {
        let subject = PublishSubject<String>()
        let ints = [Int](1...20)
        let strings = ints.map { "\($0)" }
        for string in strings {
            Thread.sleep(forTimeInterval: 0.6)
            subject.onNext(string)
        }
        return subject
    }
}
