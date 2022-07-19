//
//  TimelineItemViewModel.swift
//  TestApp
//
//  Created by Гавриил Михайлов on 18.07.2022.
//

import UIKit

struct TimelineItemViewModel {
    let subsiteIconUid: String
    let subsiteName: String
    let authorName: String
    let date: String
    let title: String
    let blocks: [BlockModel]
    let comments: String
    let likes: String
    let margins: NSDirectionalEdgeInsets
}
