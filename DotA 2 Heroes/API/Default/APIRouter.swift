//
//  APIROuter.swift
//  DotA Pro Players
//
//  Created by Ridwan Abdurrasyid on 20/07/23.
//

import Foundation

protocol APIRouter {
    var path: String { get set }
}


extension URL {
    static func construct(_ endpoint: APIRouter, queries: [String: Any] = [:]) -> URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = APIConstant.URL.base
        components.path = "/" + endpoint.path
        components.queryItems = queries.isEmpty ? nil : queries
            .compactMapValues({
                if let value = $0 as? String {
                    return value
                } else {
                    return "\($0)"
                }
            })
            .map({ URLQueryItem(name: $0.key, value: $0.value) })
        return components.url
    }
}
