//
//  StoryListViewModel.swift
//  RealStory
//
//  Created by Eric Hong Tuan Ha on 28/04/2025.
//

import SwiftUI

@MainActor
class StoryListViewModel  : ObservableObject {
    @Published var storyList : [Story] = Story.testStoryList
    @Published var currentStoryId : Int = Story.testStoryList[0].id
    @Published var showModal : Bool = false
    private var currentStory : Story {
        self.storyList.first(where: {story in story.id == currentStoryId})!
    }
    func topViewSelectStory(_ story:Story){
        currentStoryId = story.id
        showModal = true
    }
    func onClose(){
        showModal = false
    }
    func nextStory(){
        if let nextStory = storyList.nextElement(currentStory) {
            selectStory(nextStory)
        }
    }
    func previousStory(){
        if let previousStory = storyList.previousElement(currentStory) {
            selectStory(previousStory)
        }
    }
    private func selectStory( _ story: Story){
        withAnimation(.easeInOut(duration: 0.25)){
            currentStoryId = story.id
        }
    }
}
