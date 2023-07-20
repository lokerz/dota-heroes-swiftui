//
//  APIService.swift
//  DotA Pro Players
//
//  Created by Ridwan Abdurrasyid on 20/07/23.
//

import Foundation
import UIKit

public typealias APIResult<T> = Result<T, Error>

final class APIService {
    static var shared = APIService()

    // GENERAL FUNCTION
    func request<J: Fetchable, T: Decodable> (method: Method = .GET, endpoint: APIRouter, headers: [String: String] = [:], fetchModel: J, responseType: T.Type, completion: @escaping (APIResult<T>) -> Void) {

        let defaultHeaders: [String: String] = [
            "Content-Type": "application/json",
            "Accept": "application/json"
        ]
        
        guard let url = URL.construct(endpoint) else {
            fatalError("Invalid URL, please check `NetworkingEndpoint`")
        }

        var request = URLRequest(url: url, cachePolicy: .reloadIgnoringCacheData, timeoutInterval: 60)
        request.allHTTPHeaderFields = defaultHeaders.merging(headers) { (_, value) in value }
        request.httpMethod = method.rawValue.uppercased()

        if method != .GET {
            // Non GET method
            request.httpBody = try? JSONSerialization.data(withJSONObject: fetchModel.parameters(), options: .prettyPrinted)
        } else {
            // GET method
            request.url = URL.construct(endpoint, queries: fetchModel.parameters())
        }

        let task = URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) -> Void in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                return
            }

            let url = request.url?.absoluteString ?? ""
            var logOutput = " 🚀 HTTP_REQUEST: \(method.rawValue) \(url)"
            if method != .GET {
                logOutput += "\n 📦 BODY: \(fetchModel.parameters().debugDescription)"
            }
            if let responseJSON = String(data: data, encoding: .utf8) {
                logOutput += "\n ✅ JSON: \(responseJSON)"
            }
            print(logOutput)

            do {
                let result = try JSONDecoder().decode(T.self, from: data)
                completion(.success(result))
            } catch let error {
                completion(.failure(error))
            }
        })
        task.resume()
    }
    
    enum Method: String {
        case GET, POST, PATCH, PUT, DELETE
    }
}
