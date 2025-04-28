//
//  StoryImageService.swift
//  RealStory
//
//  Created by Eric Hong Tuan Ha on 28/04/2025.
//

import SwiftData
import SwiftUI

@MainActor
struct StoryImageService{
    private static var modelContainer : ModelContainer{
          get throws {
              try SwiftDataService.modelContainer
          }
      }
    static func handleSeen( storyImage : StoryImage){
        do{
            let update = storyImage
            update.seen = true
            try modelContainer.mainContext.insert(update)
        }
        catch{
            print("Error")
        }
    }
    static func handleLike( storyImage : StoryImage, like: Bool){
        do{
            let update = storyImage
            update.like = like
            try modelContainer.mainContext.insert(update)
        }
        catch{
            print("Error")
        }
    }
}
