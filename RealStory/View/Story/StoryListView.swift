//
//  StoryListView.swift
//  RealStory
//
//  Created by Eric Hong Tuan Ha on 28/04/2025.
//

import SwiftUI


struct StoryListView: View {
    let storyList : [Story]
    let onClose : () -> Void
    var body: some View {
        ZStack{
            Color.black.ignoresSafeArea()
            TabView  {
                ForEach(storyList){ story in
                    StoryView(  story: story, onClose:onClose)
                        .tag(story.id)
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
//            .modifier(SeenListManager.SyncWithView())
//            VStack{
//                Spacer()
//                Button("Reset"){
//                    SeenService.reset()
//                }
//                .foregroundStyle(.white)
//            }
        }
    }
}
 
