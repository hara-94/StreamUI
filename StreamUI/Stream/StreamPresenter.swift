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
    var view: StreamView!
}

final class StreamInteractor {
    func getMessages() -> Observable<String> {
        let subject = PublishSubject<String>()
        let int = Int.random(in: 0...30)
        let string = String(int)
        return subject
    }
}
