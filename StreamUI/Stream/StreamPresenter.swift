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
        interactor.getMessages().subscribe(onNext: { message in
            self.view.update(message)
        }).disposed(by: disposeBag)
    }
}

final class StreamInteractor {
    let subject = PublishSubject<StreamMessage>()
    
    
    func getMessages() -> Observable<StreamMessage> {
        let subject = PublishSubject<StreamMessage>()
        let strings = [Int](1...15).map { "\($0)" }
        DispatchQueue.global().async {
            for string in strings {
                Thread.sleep(forTimeInterval: 0.5)
                let message: StreamMessage = .init(text: string)
                subject.onNext(message)
            }
        }
        return subject
    }
}
