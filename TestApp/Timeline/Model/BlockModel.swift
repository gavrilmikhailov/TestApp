//
//  BlockModel.swift
//  TestApp
//
//  Created by Гавриил Михайлов on 18.07.2022.
//

struct BlockModel: Decodable {
    let type: String
    let data: BlockData
    let cover: Bool
    let hidden: Bool
    
    private enum CodingKeys: String, CodingKey {
        case type
        case data
        case cover
        case hidden
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.type = try container.decode(String.self, forKey: .type)
        switch self.type {
        case "text":
            self.data = .text(try container.decode(BlockTextModel.self, forKey: .data))
        case "media":
            self.data = .media(try container.decode(BlockMediaModel.self, forKey: .data))
        case "telegram":
            self.data = .telegram(try container.decode(BlockTelegramModel.self, forKey: .data))
        default:
            self.data = .unknown
        }
        self.cover = try container.decode(Bool.self, forKey: .cover)
        self.hidden = try container.decode(Bool.self, forKey: .hidden)
    }
}

enum BlockData {
    case text(BlockTextModel)
    case media(BlockMediaModel)
    case telegram(BlockTelegramModel)
    case unknown
}

struct BlockTextModel: Decodable {
    let text: String
    let textTruncated: String?
    
    private enum CodingKeys: String, CodingKey {
        case text
        case textTruncated = "text_truncated"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.text = try container.decode(String.self, forKey: .text)
        let textTruncated = try container.decode(String.self, forKey: .textTruncated)
        self.textTruncated = textTruncated == "<<<same>>>" ? nil : textTruncated
    }
}

struct BlockMediaModel: Decodable {
    let items: [BlockMediaItemModel]
}

struct BlockMediaItemModel: Decodable {
    let title: String
    let image: AttachModel
}

struct BlockTelegramModel: Decodable {
    
}
