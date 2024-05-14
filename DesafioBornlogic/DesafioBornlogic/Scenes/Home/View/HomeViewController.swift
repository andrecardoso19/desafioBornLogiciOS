//
//  ViewController.swift
//  DesafioBornlogic
//
//  Created by André Cardoso Aragão on 14/05/24.
//

import UIKit

final class HomeViewController: UIViewController {
    private lazy var activity: UIActivityIndicatorView = {
        let activity = UIActivityIndicatorView()
        activity.hidesWhenStopped = true
        activity.backgroundColor = .white
        activity.startAnimating()
        return activity
    }()
    
    private lazy var tableView: UITableView = {
        let view = UITableView(frame: .zero, style: .plain)
        view.backgroundColor = .white
        view.dataSource = self
        view.delegate = self
        view.rowHeight = 120
        view.register(HomeCell.self, forCellReuseIdentifier: String(describing: HomeCell.self))
        view.backgroundView = activity
        view.tableFooterView = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var viewModel: HomeViewModelProtocol
    
    init (viewModel: HomeViewModelProtocol = HomeViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.viewModel.delegate = self
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "BornLogic News"
        configureViews()
        viewModel.getNewsData()
    }
    
    private func configureViews() {
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        ])
    }
    
    private func displayAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.newsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: HomeCell.self), for: indexPath) as? HomeCell else {
            return UITableViewCell()
        }
        
        let news = viewModel.newsList[indexPath.row]
        
        cell.setupCell(newsTitle: news.title,
                       newsAuthor: news.author,
                       newsDescription: news.description,
                       imageUrl: news.urlToImage)
        
        return cell
    }
}

extension HomeViewController: HomeViewModelDelegate {
    func onSuccess() {
        DispatchQueue.main.async { [ weak self ] in
            guard let self = self else { return }
            self.tableView.reloadData()
            self.activity.stopAnimating()
        }
    }
    
    func onFailure(message: String) {
        DispatchQueue.main.async { [ weak self ] in
            guard let self = self else { return }
            displayAlert(title: "Error", message: message)
        }
    }
}
