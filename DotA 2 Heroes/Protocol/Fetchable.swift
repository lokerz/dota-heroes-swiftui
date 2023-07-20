//
//  Fetchable.swift
//  DotA Pro Players
//
//  Created by Ridwan Abdurrasyid on 20/07/23.
//

import Foundation

protocol Fetchable: Encodable {
    func parameters() -> [String : Any]
}

extension Fetchable {
    public var dictionary: [String: Any]? {
        let encoder = JSONEncoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase
        guard let data = try? encoder.encode(self) else { return nil }
        return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)).flatMap { $0 as? [String: Any] }
    }
}
