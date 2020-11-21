//
//  StreamView.swift
//  StreamUI
//
//  Created by hikaruhara on 2020/11/20.
//

import UIKit
import RxSwift
import RxCocoa

final class StreamView: UIView {
    private let tableView: UITableView = .init()
    private let disposeBag: DisposeBag = .init()
    var presenter: StreamPresenter!
    var viewModel: StreamViewModel? = .init(messages: [])
    
    convenience init(presenter: StreamPresenter) {
        self.init(frame: .zero)
        self.presenter = presenter
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        set()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func set() {
        addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
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
        print("count: \(viewModel.messages.count)")
        return viewModel.messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.backgroundColor = .black
        cell.textLabel?.text = viewModel?.messages[indexPath.row].text
        cell.textLabel?.textColor = .white
        return cell
    }
}

extension StreamView {
    func update(_ message: StreamMessage) {
        viewModel?.messages.append(message)
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}
