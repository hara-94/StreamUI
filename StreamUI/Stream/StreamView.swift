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
        let blurEffect: UIBlurEffect = .init(style: .light)
        let effectView: UIVisualEffectView = .init(effect: blurEffect)
        addSubview(effectView)
        effectView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            effectView.topAnchor.constraint(equalTo: topAnchor),
            effectView.bottomAnchor.constraint(equalTo: bottomAnchor),
            effectView.leadingAnchor.constraint(equalTo: leadingAnchor),
            effectView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
        addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
}

extension StreamView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension StreamView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let viewModel = viewModel else { return 0 }
        return viewModel.messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = viewModel?.messages[indexPath.row].text
        cell.backgroundColor = .clear
        return cell
    }
}

extension StreamView {
    func update(_ message: StreamMessage) {
        viewModel?.messages.append(message)
        DispatchQueue.main.async {
            self.tableView.reloadData()
            if let viewModel = self.viewModel {
                self.tableView.scrollToRow(at: .init(row: viewModel.messages.count-1, section: 0), at: .bottom, animated: true)
            }
        }
    }
}
