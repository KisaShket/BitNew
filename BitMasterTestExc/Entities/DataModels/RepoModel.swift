//
//  RepoModel.swift
//  BitMasterTestExc
//
//  Created by Kisa Shket on 30.03.2021.
//

import Foundation

public class RepoModel: NSObject, Decodable {
    
    @objc public let name: String?
    @objc public let stargazersCount: NSNumber?
    @objc public var latitude = Float.random(in: -90...90)
    @objc public var longitude = Float.random(in: -180...180)
    
    enum CodingKeys: String, CodingKey{
        case name
        case stargazersCount = "stargazers_count"
    }
    
    public required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        stargazersCount = try values.decodeIfPresent(Int.self, forKey: .stargazersCount) as NSNumber?
    }
}
