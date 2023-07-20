//
//  HeroesView.swift
//  DotA 2 Heroes
//
//  Created by Ridwan Abdurrasyid on 20/07/23.
//

import SwiftUI

struct HeroesView: View {
    var viewModel: HeroesVM!
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
    
    init(viewModel: HeroesVM!) {
        self.viewModel = viewModel
        
        self.viewModel.requestHero(id: 1) { model in
            print(model)
        }
    }
}

struct HeroesView_Previews: PreviewProvider {
    static var previews: some View {
        let api = HeroesAPI()
        let service = HeroesService(heroesAPI: api)
        let vm = HeroesVM(service: service)
        HeroesView(viewModel: vm)
    }
}
