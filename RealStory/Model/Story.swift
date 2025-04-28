//
//  Story.swift
//  RealStory
//
//  Created by Eric Hong Tuan Ha on 28/04/2025.
//

import SwiftData

@Model
class Story: Identifiable, Hashable {
    var id : Int
    var imageList : [StoryImage]
    var user : User
    init(id: Int, imageList: [StoryImage], user: User) {
        self.id = id
        self.imageList = imageList
        self.user = user
    }
}
extension Story{
    var seen : Bool {
        for image in imageList {
            if !image.seen{
                return false
            }
        }
        return true
    }
}
extension Story{
    static var testStoryList : [Story] {
            return Story.generateStoryList(userList: JsonService.userList)
    }
    private static var currentId = 1
    private static func generateStoryList(userList:[User]) -> [Story]{
        return userList.map{generateStoryList(user: $0)}
    }
    private static func generateStoryList(user:User) -> Story{
        let result =  Story(id: currentId, imageList: .generateStoryImageList, user: user)
        currentId += 1
        return result
    }
}
