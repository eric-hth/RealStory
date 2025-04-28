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
    func topViewSelectStory(_ story:Story){
        currentStoryId = story.id
        showModal = true
    }
}
