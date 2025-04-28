//
//  StoryService.swift
//  RealStory
//
//  Created by Eric Hong Tuan Ha on 28/04/2025.
//


import SwiftData
import SwiftUI

@MainActor
struct StoryService{
    private static var modelContainer : ModelContainer{
          get throws {
              try SwiftDataService.modelContainer
          }
      }
    static func resetData(){
        SwiftDataService.deleteAll()
        StoryService.save(storyList: Story.testStoryList)
    }
    static func resetDataIfNecessary(){
        if count() == 0{
            SwiftDataService.deleteAll()
            StoryService.save(storyList: Story.testStoryList)
        }
    }
    private static func save( storyList : [Story] ){
        do{
            for story in storyList{
                try modelContainer.mainContext.insert(story)
                
            }
            try modelContainer.mainContext.save()
        }
        catch{
            print("Error")
        }
    }
    private static func count() -> Int{
        do{
            return ((try modelContainer.mainContext.fetch(FetchDescriptor<Story>( ))) ?? []).count
        }
        catch{
            return 0
            print(error)
        }
    }
}


extension StoryService{
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
 
