//
//  ContentView.swift
//  RealStory
//
//  Created by Eric Hong Tuan Ha on 28/04/2025.
//

import SwiftUI
import SwiftData

struct HomeView: View {
    @StateObject var storyListViewModel = StoryListViewModel()
    @Query( sort: \Story.id) var storyList: [Story]
    var body: some View {
        VStack {
            StoryListTopView(storyListViewModel: storyListViewModel )
            .padding(.top,10)
            Spacer()
            VStack{
                Button("Reset Data"){
                    StoryService.resetData()
                }
            }
 
        }
        .fullScreenCover(isPresented: $storyListViewModel.showModal, content: {
            StoryListView(storyListViewModel: storyListViewModel , onClose: { storyListViewModel.showModal = false})
        })
        .modifier(StoryListManager.SyncWithView(storyListViewModel: storyListViewModel))
        .onAppear{
            StoryService.resetDataIfNecessary()
        }
    }
}



import SwiftUI
import Combine
import SwiftData
@MainActor
class StoryListManager : ObservableObject  {
    static var shared = StoryListManager()
    @Published var storyList : [Story]?
    private var subscribers = Set<AnyCancellable>()
    private init(){
    }
}

 
 
