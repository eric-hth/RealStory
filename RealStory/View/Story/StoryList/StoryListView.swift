//
//  StoryListView.swift
//  RealStory
//
//  Created by Eric Hong Tuan Ha on 28/04/2025.
//

import SwiftUI


struct StoryListView: View {
    @ObservedObject var storyListViewModel : StoryListViewModel
    let onClose : () -> Void
    var body: some View {
        ZStack{
            Color.black.ignoresSafeArea()
            TabView(selection: $storyListViewModel.currentStoryId){
                ForEach(storyListViewModel.storyList){ story in
                    StoryView(  storyListViewModel: storyListViewModel, story: story )
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
 
