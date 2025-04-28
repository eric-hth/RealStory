//
//  ContentView.swift
//  RealStory
//
//  Created by Eric Hong Tuan Ha on 28/04/2025.
//

import SwiftUI

struct HomeView: View {

    @StateObject var storyListViewModel = StoryListViewModel()
    var body: some View {
        VStack {
            StoryListTopView(storyListViewModel: storyListViewModel )
            .padding(.top,10)
            Spacer()
        }
        .fullScreenCover(isPresented: $storyListViewModel.showModal, content: {
            StoryListView(storyListViewModel: storyListViewModel , onClose: { storyListViewModel.showModal = false})
        })
        .onAppear{
        }
    }
}
 


