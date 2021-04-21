//
//  GitResponse.swift
//  BitMasterTestExc
//
//  Created by Kisa Shket on 30.03.2021.
//

import Foundation

struct GitResponse: Decodable {
    let items: [RepoModel]?
    let totalCount: Int?
    
    enum CodingKeys: String, CodingKey{
        case totalCount = "total_count"
        case items
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        totalCount = try values.decodeIfPresent(Int.self, forKey: .totalCount)
        items = try values.decodeIfPresent([RepoModel].self, forKey: .items)
    }
}
