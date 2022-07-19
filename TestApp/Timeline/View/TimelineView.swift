//
//  TimelineView.swift
//  TestApp
//
//  Created by Гавриил Михайлов on 17.07.2022.
//

import UIKit

final class TimelineView: UIView {
    
    private enum ViewMetrics {
        static let backgroundColor = UIColor(red: 0.898, green: 0.898, blue: 0.898, alpha: 1)
    }
    
    private weak var delegate: TimelineViewDelegate?
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(TimelineItemCell.self, forCellReuseIdentifier: "TimelineItemCell")
        tableView.separatorStyle = .none
        tableView.sectionHeaderTopPadding = .zero
        tableView.backgroundColor = ViewMetrics.backgroundColor
        tableView.allowsSelection = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        tableView.refreshControl = refreshControl

        return tableView
    }()
    
    private lazy var loadingIndicatorView: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    init(
        frame: CGRect,
        delegate: TimelineViewDelegate,
        tableDataSource: UITableViewDataSource
    ) {
        self.delegate = delegate
        super.init(frame: frame)
        tableView.dataSource = tableDataSource
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        backgroundColor = ViewMetrics.backgroundColor
        addSubview(loadingIndicatorView)
        addSubview(tableView)
        
        NSLayoutConstraint.activate([
            loadingIndicatorView.centerXAnchor.constraint(equalTo: centerXAnchor),
            loadingIndicatorView.centerYAnchor.constraint(equalTo: centerYAnchor),

            tableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
        loadingIndicatorView.startAnimating()
        tableView.isHidden = true
    }
    
    @objc private func refresh() {
        delegate?.refresh()
    }
    
    func configure(isLoading: Bool) {
        if isLoading {
            loadingIndicatorView.startAnimating()
            loadingIndicatorView.isHidden = false
            tableView.isHidden = true
        } else {
            loadingIndicatorView.stopAnimating()
            loadingIndicatorView.isHidden = true
            tableView.isHidden = false
            tableView.refreshControl?.endRefreshing()
        }
    }
    
    func reloadTableView() {
        tableView.reloadData()
    }
    
    func startLoadingMore() {
        guard tableView.tableFooterView == nil else { return }
        let indicatorView = UIActivityIndicatorView()
        indicatorView.frame = CGRect(x: 0.0, y: 0.0, width: tableView.bounds.width, height: 40)
        indicatorView.startAnimating()
        tableView.tableFooterView = indicatorView
    }

    func stopLoadingMore() {
        tableView.tableFooterView = nil
    }
}
