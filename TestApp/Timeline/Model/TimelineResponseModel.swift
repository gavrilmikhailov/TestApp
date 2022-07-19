//
//  TimelineResponseModel.swift
//  TestApp
//
//  Created by Гавриил Михайлов on 18.07.2022.
//

struct TimelineResponseModel: Decodable {
    let message: String
    let result: TimelineResultModel
}

struct TimelineResultModel: Decodable {
    let items: [TimelineItemModel]
    let lastId: String
    let lastSortingValue: String
    
    private enum CodingKeys: CodingKey {
        case items
        case lastId
        case lastSortingValue
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.items = try container.decode([TimelineItemModel].self, forKey: .items)
        if let intLastId = try? container.decode(Int.self, forKey: .lastId) {
            self.lastId = String(intLastId)
        } else {
            self.lastId = try container.decode(String.self, forKey: .lastId)
        }
        self.lastSortingValue = try container.decode(String.self, forKey: .lastSortingValue)
    }
}

struct TimelineItemModel: Decodable {
    let type: String
    let data: TimelineItemDataModel
}

struct TimelineItemDataModel: Decodable {
    let title: String
    let date: Int
    let author: AuthorModel
    let subsite: SubsiteModel
    let blocks: [BlockModel]
    let counters: CountersModel
    let likes: LikesModel
}

struct AuthorModel: Decodable {
    let id: Int
    let type: Int
    let subtype: String
    let name: String
    let description: String
}

struct SubsiteModel: Decodable {
    let id: Int
    let name: String
    let avatar: AttachModel
}

struct AttachModel: Decodable {
    let type: String
    let data: AttachDataModel
}

struct AttachDataModel: Decodable {
    let uuid: String
    let width: Int
    let height: Int
}

struct CountersModel: Decodable {
    let comments: Int
    let favorites: Int
    let reposts: Int
}

struct LikesModel: Decodable {
    let summ: Int
    let counter: Int
    let isLiked: Int
    let isHidden: Bool
}
