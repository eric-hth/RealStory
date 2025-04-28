//
//  AsyncImage.swift
//  RealStory
//
//  Created by Eric Hong Tuan Ha on 28/04/2025.
//

import SwiftUI

struct AsyncImage : View {
    let url : String
    var body: some View {
        HStack{
            SwiftUI.AsyncImage(url: URL(string:url)) { phase in
                switch phase {
                    case .failure:
                        Image(systemName: "photo")
                            .font(.largeTitle)
                    case .success(let image):
                        image
                            .resizable()
                default:
                    ProgressView()
                }
            }
        }
    }
}
