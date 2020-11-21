//
//  ViewController.swift
//  StreamUI
//
//  Created by hikaruhara on 2020/11/20.
//

import UIKit

final class TopViewController: UIViewController {
    private let tableView: UITableView = .init()
    private let resource = [Int](0...20)
    private let colors: [UIColor] = [
        .red, .blue, .yellow, .magenta, .orange, .brown, .gray, .green, .cyan, .purple, .systemPink, .systemIndigo
    ]
    var presenter: TopPresenter!
    
    override func loadView() {
        super.loadView()
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.widthAnchor.constraint(equalTo: view.widthAnchor),
            tableView.heightAnchor.constraint(equalTo: view.heightAnchor)
        ])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        StreamService.shared.display(in: view, at: .third)
    }
}

extension TopViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
}

extension TopViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return resource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "\(resource[indexPath.row])"
        cell.backgroundColor = colors[Int.random(in: 0...colors.count-1)]
        return cell
    }
}
