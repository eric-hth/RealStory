//
//  Story.swift
//  RealStory
//
//  Created by Eric Hong Tuan Ha on 28/04/2025.
//


struct Story: Identifiable, Hashable {
    let id : Int
    let imageList : [StoryImage]
    let user : User
}

extension Story{
    static var storyList : [Story] {
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
