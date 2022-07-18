//
//  TimelineViewController.swift
//  TestApp
//
//  Created by Гавриил Михайлов on 17.07.2022.
//

import UIKit

protocol TimelineViewDelegate: AnyObject {
    
}

final class TimelineViewController: UIViewController {
    
    private let timelineProvider = TimelineProvider()
    private let tableDataSource = TimelineTableDataSource()
    private let tableDelegate = TimelineTableDelegate()
    
    private lazy var customView = view as? TimelineView
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = TimelineView(
            frame: .zero,
            delegate: self,
            tableDataSource: tableDataSource,
            tableDelegate: tableDelegate
        )
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchTimeline()
    }

    private func fetchTimeline() {
        timelineProvider.fetchTimeline(queryParams: ["allSite": "true", "sorting": "day"]) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(model):
                self.tableDataSource.representableModels = self.getTimelineItemViewModels(models: model.result.items)
                self.customView?.configure(isLoading: false)
                self.customView?.reloadTableView()
            case let .failure(error):
                let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default))
                self.present(alert, animated: true)
            }
        }
    }
    
    private func getTimelineItemViewModels(models: [TimelineItemModel]) -> [TimelineItemViewModel] {
        let count = models.count
        return models.enumerated().map { (index, item) in
            TimelineItemViewModel(
                model: item,
                margins: NSDirectionalEdgeInsets(
                    top: index == 0 ? 0 : 10,
                    leading: 0,
                    bottom: index == count - 1 ? 0 : 10,
                    trailing: 0
                )
            )
        }
    }
}

extension TimelineViewController: TimelineViewDelegate {
    
}
