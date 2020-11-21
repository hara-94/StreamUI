//
//  StreamView.swift
//  StreamUI
//
//  Created by hikaruhara on 2020/11/20.
//

import UIKit

final class StreamView: UIView {
    private let tableView: UITableView = .init()
    var presenter: StreamPresenter!
    var viewModel: StreamViewModel?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        set()
        presenter.didLoad()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func set() {
        addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
}

extension StreamView: UITableViewDelegate { }

extension StreamView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let viewModel = viewModel else { return 0 }
        return viewModel.messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        .init()
    }
}

extension StreamView {
    func update(_ message: String) {
        viewModel?.messages.append(message)
        tableView.reloadData()
    }
}
