//
//  StoryListViewModel.swift
//  RealStory
//
//  Created by Eric Hong Tuan Ha on 28/04/2025.
//

import SwiftUI
import Combine
import SwiftData

@MainActor
class StoryListViewModel  : ObservableObject {
    @Published var storyList : [Story]?
    
    @Published var currentStoryId : Int?
    @Published var showModal : Bool = false
    private var subscribers = Set<AnyCancellable>()
    init(){
        StoryListManager.shared.$storyList
        .combineLatest($showModal)
        .sink{ storyList, showModal in
             self.storyList = storyList
        }
        .store(in: &subscribers)
    }
    
    private var currentStory : Story? {
        self.storyList?.first(where: {story in story.id == currentStoryId})!
    }
    func topViewSelectStory(_ story:Story){
        currentStoryId = story.id
        showModal = true
    }
    func onClose(){
        showModal = false
    }
    func nextStory(){
        if let nextStory = storyList?.nextElement(currentStory) {
            selectStory(nextStory)
        }
    }
    func previousStory(){
        if let previousStory = storyList?.previousElement(currentStory) {
            selectStory(previousStory)
        }
    }
    private func selectStory( _ story: Story){
        withAnimation(.easeInOut(duration: 0.25)){
            currentStoryId = story.id
        }
    }
    // MARK: Loom
    func handleStoryAppear( _ story : Story){
        // If story is near the end of the list, call getNextPage()
    }
    private func getNextPage(){
        // Update story list
    }
}

extension StoryListManager{
    struct SyncWithView: ViewModifier {
        @ObservedObject var storyListViewModel : StoryListViewModel
        @Query( sort: \Story.id) var storyList: [Story]
        func body(content: Content) -> some View {
                  content.onAppear{
                      storyListViewModel.storyList = storyList
                }
                .onChange(of: storyList){ storyList in
                    storyListViewModel.storyList = storyList
                }
            }
    }
}
 
 
