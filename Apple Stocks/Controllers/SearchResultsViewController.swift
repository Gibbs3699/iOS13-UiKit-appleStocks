//
//  SearchResultsViewController.swift
//  Apple Stocks
//
//  Created by TheGIZzz on 18/7/2565 BE.
//

import UIKit

/// Delegate for search resutls
protocol SearchResultsViewControllerDelegate: AnyObject {
    /// Notify delegate of selection
    /// - Parameter searchResult: Result that was picked
    func SearchResultsViewControllerDidSelect(searchResult: String)
}

class SearchResultsViewController: UIViewController {

    weak var delegate: SearchResultsViewControllerDelegate?
    
    private var results: [String] = []
    
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(SearchResultsTableViewCell.self, forCellReuseIdentifier: SearchResultsTableViewCell.identifier)
        return tableView
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }

    private func setupTableView() {
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.contentInsetAdjustmentBehavior = .never
        
    }
    
    public func update(with results: [String]) {
        self.results = results
        tableView.reloadData()
    }
}

extension SearchResultsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchResultsTableViewCell.identifier, for: indexPath)
        
        cell.textLabel?.text = "AAPL"
        cell.detailTextLabel?.text = "Apple Inc."
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        delegate?.SearchResultsViewControllerDidSelect(searchResult: "AAPL")
    }
    
}
