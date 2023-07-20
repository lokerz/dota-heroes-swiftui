//
//  HeroesView.swift
//  DotA 2 Heroes
//
//  Created by Ridwan Abdurrasyid on 20/07/23.
//

import SwiftUI

struct HeroesView: View {
    var viewModel: HeroesVM!
    
    @State private var hero: HeroesModel?
    @State private var id = 0
    @State private var fadeOut = false

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            
            self.loadImage(from: self.hero?.image ?? "", alternative: self.hero?.image2 ?? "", width: UIScreen.width, height: UIScreen.height, opacity: 0.15, contentMode: .fill)

            VStack(alignment: .center, spacing: 4) {
                ScrollView {
                    VStack(alignment: .leading, spacing: 16) {
                        Text("")
                        Text("")
                        Text("")

                        ZStack(alignment: .center) {
                            self.loadImage(from: APIConstant.URL.dotaIcon, width: UIScreen.width, height: UIScreen.height * 3 / 4)
                                .transition(.opacity.animation(.default))

                            self.loadImage(from: self.hero?.image ?? "", alternative: self.hero?.image2 ?? "", width: UIScreen.width, height: UIScreen.height * 3 / 4)
                                .transition(.opacity.animation(.default))

                        }
                        
                        Text("")
                        Text(self.hero?.name ?? "")
                            .foregroundColor(.white)
                            .font(.system(size: 32, weight: .bold))
                        Text(self.hero?.desc ?? "")
                            .foregroundColor(.white)
                            .font(.system(size: 14, weight: .medium))
                            .italic()
                    }
                }
                Text("")
                HStack {
                    Button("Previous") {
                        self.requestPreviousData()
                    }
                    .foregroundColor(.white)
                    .font(.system(size: 16, weight: .bold))
                    .frame(maxWidth: .infinity)

                    
                    Button("Next") {
                        self.requestNextData()
                    }
                    .foregroundColor(.white)
                    .font(.system(size: 16, weight: .bold))
                    .frame(maxWidth: .infinity)

                }
            }
            .padding()

        }
        .onAppear(perform: self.requestNextData)
    }

    init(viewModel: HeroesVM!) {
        self.viewModel = viewModel
    }
    
    func requestNextData() {
        self.id += 1
        self.hero = nil
        self.requestData()
    }

    func requestPreviousData() {
        self.id -= 1
        self.hero = nil
        self.requestData()
    }

    func requestData() {
        self.fadeOut = true
        self.viewModel.requestHero(id: self.id) { (hero) in
            DispatchQueue.main.async {
                withAnimation {
                    self.hero = hero
                    self.fadeOut = false
                }
            }
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
