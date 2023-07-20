//
//  HeroesVM.swift
//  DotA 2 Heroes
//
//  Created by Ridwan Abdurrasyid on 20/07/23.
//

import Foundation

class HeroesVM {
    private var heroesService: HeroesService
    
    init(service: HeroesService) {
        self.heroesService = service
    }
    
    func requestHero(id: Int, completion: ((HeroesModel) -> Void)?) {
        let body = HeroesBody(language: "english", heroId: id)
        self.heroesService.request(body: body) { (result) in
            switch result {
            case .success(let model): completion?(model)
            case .failure(let error): print(error)
            }
        }
    }
}
