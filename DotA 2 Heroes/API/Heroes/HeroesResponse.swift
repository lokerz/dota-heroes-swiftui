//
//  HeroesResponse.swift
//  DotA Pro Players
//
//  Created by Ridwan Abdurrasyid on 20/07/23.
//

import Foundation

struct HeroesResponse: Decodable {
    let result: HeroesResult?
}

struct HeroesResult: Decodable {
    let data: HeroesData?
}

struct HeroesData: Decodable {
    let heroes: [Heroes]?
}

struct Heroes: Decodable {
    let name: String?
    let desc: String?
    let bio: String?
    
    enum CodingKeys: String, CodingKey {
        case name = "name_loc"
        case desc = "npe_desc_loc"
        case bio = "bio_loc"
    }
}
