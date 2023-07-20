//
//  View.swift
//  DotA 2 Heroes
//
//  Created by Ridwan Abdurrasyid on 20/07/23.
//

import SwiftUI

extension View {
    
    func loadImage(from url: String, alternative: String = "", width: CGFloat, height: CGFloat, opacity: Double = 1) -> some View {
        
        AsyncImage(url: URL(string: url)) { phase in
            switch phase {
            case .empty:
                ProgressView()
            case .success(let image):
                image.resizable()
                    .scaledToFill()
                    .frame(maxWidth: width, maxHeight: height, alignment: .center)
                    .frame(alignment: .center)
                    .opacity(opacity)
            case .failure:
                if alternative != "" {
                    AsyncImage(url: URL(string: alternative)) { phase in
                        switch phase {
                        case .empty:
                            ProgressView()
                        case .success(let image):
                            image.resizable()
                                .scaledToFill()
                                .frame(maxWidth: width, maxHeight: height, alignment: .center)
                                .opacity(opacity)
                        case .failure:
                            EmptyView()
                        @unknown default:
                            EmptyView()
                        }
                    }
                } else {
                    EmptyView()
                }
            @unknown default:
                EmptyView()
            }
        }
    }
}
