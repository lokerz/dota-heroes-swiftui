//
//  DotA_2_HeroesApp.swift
//  DotA 2 Heroes
//
//  Created by Ridwan Abdurrasyid on 20/07/23.
//

import SwiftUI

@main
struct DotA_2_HeroesApp: App {
    var body: some Scene {
        WindowGroup {
            let api = HeroesAPI()
            let service = HeroesService(heroesAPI: api)
            let vm = HeroesVM(service: service)
            HeroesView(viewModel: vm)
        }
    }
}
