//
//  HeroesService.swift
//  DotA 2 Heroes
//
//  Created by Ridwan Abdurrasyid on 20/07/23.
//

import Foundation

class HeroesService {
    private var heroesAPI: HeroesAPI
    
    init(heroesAPI: HeroesAPI) {
        self.heroesAPI = heroesAPI
    }
    
    func request(body: HeroesBody, completion: @escaping (APIResult<HeroesModel>) -> Void) {
        APIService.shared.request(method: .GET,
                                  endpoint: self.heroesAPI,
                                  headers: [:],
                                  fetchModel: body,
                                  responseType: HeroesResponse.self) { result in
            
            switch result {
            case .success(let response):
                guard let data = response.result?.data?.heroes?.first else {return}
                let model = HeroesModel(name: data.name ?? "",
                                        desc: data.desc ?? "",
                                        bio: data.bio ?? "",
                                        image: APIConstant.URL.imageBase + (data.name?.lowercased().removeAllButAlphabet() ?? "juggernaut") + ".png")
                completion(.success(model))
            case .failure(let error):
                completion(.failure(error))
            }

        }
    }
}
