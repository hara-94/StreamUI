//
//  StreamService.swift
//  StreamUI
//
//  Created by hikaruhara on 2020/11/21.
//

import UIKit

final class StreamService {
    static let shared: StreamService = .init()
    private init() { }
    
    func display(in view: UIView, at qadrant: Qadrant) {
        let streamView: StreamView = .init()
        streamView.presenter = .init(view: streamView)
        
    }
}

extension StreamService {
    enum Qadrant {
        case first, second, third, fourth
        
        func position() {
            switch self {
            case .first:
                print("first")
            case .second:
                print("second")
            case .third:
                print("third")
            case .fourth:
                print("fourth")
            }
        }
    }
}
