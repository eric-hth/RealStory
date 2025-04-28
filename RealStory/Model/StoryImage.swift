//
//  StoryImage.swift
//  RealStory
//
//  Created by Eric Hong Tuan Ha on 28/04/2025.
//

import SwiftData

@Model
class StoryImage: Identifiable, Hashable {
    var id : Int
    var url : String
    var like : Bool
    var seen : Bool
    init(id: Int, url: String, like: Bool = false, seen: Bool = false) {
        self.id = id
        self.url = url
        self.like = like
        self.seen = seen
    }
}


extension Array where Element == StoryImage{
    private static var currentId = 1
    static var generateStoryImageList : [StoryImage]{
       let result =  [StoryImage(id: currentId, url: .image1), StoryImage(id: currentId + 1, url: .image2),StoryImage(id: currentId + 2, url: .image3)]
        currentId += 3
        return result
    }
}


private extension String{
    static let image1 = "https://pbs.twimg.com/media/GWzTKvqXkAE0fXx?format=jpg&name=large"
    static let image2 = "https://pbs.twimg.com/media/GWzTKRbbAAALjbn?format=jpg&name=large"
    static let image3 = "https://pbs.twimg.com/media/GWADp3EaoAIfYRH?format=jpg&name=medium"
}
