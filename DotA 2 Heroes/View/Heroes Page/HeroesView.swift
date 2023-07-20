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

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            VStack {
                ScrollView {
                    VStack(alignment: .leading, spacing: 8) {
                        ZStack(alignment: .center) {
                            ZStack {
                                Color.gray
                            }
                            .frame(width: 320, height: 320, alignment: .center)
                            .cornerRadius(160)

                            AsyncImage(url: URL(string: hero?.image ?? "")) { phase in
                                switch phase {
                                case .empty:
                                    ProgressView()
                                case .success(let image):
                                    image.resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(maxWidth: UIScreen.width, maxHeight: 300)
                                case .failure:
                                    AsyncImage(url: URL(string: hero?.image2 ?? "")) { phase in
                                        switch phase {
                                        case .empty:
                                            ProgressView()
                                        case .success(let image):
                                            image.resizable()
                                                .aspectRatio(contentMode: .fit)
                                                .frame(maxWidth: UIScreen.width, maxHeight: 300)
                                        case .failure:
                                            EmptyView()
                                        @unknown default:
                                            EmptyView()
                                        }
                                    }
                                @unknown default:
                                    EmptyView()
                                }
                            }
                        }
                        Text("")
                        Text(hero?.name ?? "")
                            .foregroundColor(.white)
                            .font(.system(size: 32, weight: .bold))
                        Text(hero?.desc ?? "")
                            .foregroundColor(.white)
                            .font(.system(size: 14, weight: .medium))
                            .italic()
                        Text(hero?.bio ?? "")
                            .foregroundColor(.white)
                            .font(.system(size: 14))
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
        self.requestData()
    }

    func requestPreviousData() {
        self.id -= 1
        self.requestData()
    }

    func requestData() {
        self.viewModel.requestHero(id: self.id) { (hero) in
            DispatchQueue.main.async {
                self.hero = hero
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
