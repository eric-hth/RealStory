//
//  ContentView.swift
//  RealStory
//
//  Created by Eric Hong Tuan Ha on 28/04/2025.
//

import SwiftUI

struct HomeView: View {
    @State private var showStoryListView: Bool = false
    var body: some View {
        VStack {
            StoryListTopView(storyList: Story.storyList, onSelect: {story in
                    print(story)
                showStoryListView = true
            })
            .padding(.top,10)
            Spacer()
        }
        .fullScreenCover(isPresented: $showStoryListView, content: {
            StoryListView(storyList: Story.storyList, onClose: { showStoryListView = false})
        })
        .onAppear{
        }
    }
}
 

