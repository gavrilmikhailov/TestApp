//
//  TimelineViewController.swift
//  TestApp
//
//  Created by Гавриил Михайлов on 17.07.2022.
//

import UIKit

protocol TimelineViewDelegate: AnyObject {
    
    func refresh()
    
    func loadMore()

    func openImage(image: UIImage)
}

final class TimelineViewController: UIViewController {
    
    private let timelineProvider: TimelineProvider
    private let tableDataSource: TimelineTableDataSource
    
    private lazy var customView = view as? TimelineView

    private var canLoadMore: Bool = true
    private var lastId: String?
    private var lastSortingValue: String?
    
    init(
        timelineProvider: TimelineProvider = TimelineProvider(),
        tableDataSource: TimelineTableDataSource = TimelineTableDataSource()
    ) {
        self.timelineProvider = timelineProvider
        self.tableDataSource = tableDataSource
        super.init(nibName: nil, bundle: nil)
        self.tableDataSource.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = TimelineView(
            frame: .zero,
            delegate: self,
            tableDataSource: tableDataSource
        )
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchTimeline(isMore: false)
    }

    private func fetchTimeline(isMore: Bool) {
        if isMore, !canLoadMore {
            return
        }
        var queryParams: [String: String] = [
            "allSite": "true",
            "sorting": "day"
        ]
        if isMore, let lastId = lastId, let lastSortingValue = lastSortingValue {
            queryParams["lastId"] = lastId
            queryParams["lastSortingValue"] = lastSortingValue
        }
        timelineProvider.fetchTimeline(queryParams: queryParams) { [weak self] result in
            guard let self = self else { return }
            self.customView?.configure(isLoading: false)
            switch result {
            case let .success(model):
                if self.lastId == model.result.lastId, self.lastSortingValue == model.result.lastSortingValue {
                    self.canLoadMore = false
                } else {
                    self.lastId = model.result.lastId
                    self.lastSortingValue = model.result.lastSortingValue
                }
                let viewModels = self.getTimelineItemViewModels(models: model.result.items)
                self.tableDataSource.representableModels = isMore ? (self.tableDataSource.representableModels + viewModels) : viewModels
                self.customView?.reloadTableView()
                self.customView?.stopLoadingMore()
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
    
    func refresh() {
        canLoadMore = true
        fetchTimeline(isMore: false)
    }
    
    func loadMore() {
        customView?.startLoadingMore()
        fetchTimeline(isMore: true)
    }
    
    func openImage(image: UIImage) {
        let imageViewerViewController = ImageViewerViewController(image: image)
        imageViewerViewController.modalTransitionStyle = .crossDissolve
        imageViewerViewController.modalPresentationStyle = .fullScreen
        present(imageViewerViewController, animated: true)
    }
}
