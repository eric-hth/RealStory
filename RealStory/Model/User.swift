//
//  User.swift
//  RealStory
//
//  Created by Eric Hong Tuan Ha on 28/04/2025.
//


struct User: Identifiable, Hashable, Codable {
    let id : Int
    let name : String
    let profile_picture_url : String
}
