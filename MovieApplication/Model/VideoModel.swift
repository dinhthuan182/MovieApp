//
//  VideoModel.swift
//  MovieApplication
//
//  Created by Catalina on 2/19/20.
//  Copyright © 2020 Catalina. All rights reserved.
//

import Foundation
struct VideoApiResponse {
    let id: Int
    let videos: [Video]
}

extension VideoApiResponse: Decodable {
    enum VideoApiResponseCodingKeys: String, CodingKey {
        case id
        case videos = "results"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: VideoApiResponseCodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        videos = try container.decode([Video].self, forKey: .videos)
    }
}

struct Video {
    let id: String
    let key: String
    let name: String
    let site: String
    let size: Int
    let type: String
}
extension Video: Decodable {
    enum VideoCodingKeys: String, CodingKey {
        case id
        case key
        case name
        case site
        case size
        case type
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: VideoCodingKeys.self)
        
        id = try container.decode(String.self, forKey: .id)
        key = try container.decode(String.self, forKey: .key)
        name = try container.decode(String.self, forKey: .name)
        site = try container.decode(String.self, forKey: .site)
        size = try container.decode(Int.self, forKey: .size)
        type = try container.decode(String.self, forKey: .type)
    }
}
