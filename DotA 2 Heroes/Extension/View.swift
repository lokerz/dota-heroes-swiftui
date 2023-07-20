//
//  View.swift
//  DotA 2 Heroes
//
//  Created by Ridwan Abdurrasyid on 20/07/23.
//

import SwiftUI

extension View {
    
    func loadImage(from url: String, alternative: String = "", width: CGFloat, height: CGFloat, opacity: Double = 1, contentMode: ContentMode = .fit) -> some View {
        AsyncImage(url: URL(string: url), transaction: .init(animation: .spring(response: 0.5, dampingFraction: 1.0, blendDuration: 0.3))) { phase in
            switch phase {
            case .empty:
                EmptyView()
            case .success(let image):
                image.resizable()
                    .aspectRatio(contentMode: contentMode)
                    .frame(maxWidth: width, maxHeight: height, alignment: .center)
                    .opacity(opacity)
                    .transition(.opacity)
            case .failure:
                if alternative != "" {
                    AsyncImage(url: URL(string: alternative), transaction: .init(animation: .spring(response: 0.5, dampingFraction: 1.0, blendDuration: 0.3))) { phase in
                        switch phase {
                        case .empty:
                            EmptyView()
                        case .success(let image):
                            image.resizable()
                                .aspectRatio(contentMode: contentMode)
                                .frame(maxWidth: width, maxHeight: height, alignment: .center)
                                .opacity(opacity)
                                .transition(.opacity)
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
