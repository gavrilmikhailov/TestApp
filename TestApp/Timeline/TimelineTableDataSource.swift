//
//  TimelineTableDataSource.swift
//  TestApp
//
//  Created by Гавриил Михайлов on 17.07.2022.
//

import UIKit

final class TimelineTableDataSource: NSObject, UITableViewDataSource {
    
    var representableModels: [TimelineItemViewModel] = []
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        representableModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TimelineItemCell", for: indexPath) as? TimelineItemCell else {
            return UITableViewCell()
        }
        let model = representableModels[indexPath.row]
        cell.configure(with: model)
        return cell
    }
}
