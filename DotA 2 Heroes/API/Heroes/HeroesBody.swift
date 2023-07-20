//
//  HeroesBody.swift
//  DotA 2 Heroes
//
//  Created by Ridwan Abdurrasyid on 20/07/23.
//

import Foundation

struct HeroesBody: Fetchable {
    var language: String
    var heroId: Int
    
    func parameters() -> [String : Any] {
        return self.dictionary ?? [String : Any]()
    }
}
