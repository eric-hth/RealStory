//
//  JsonService.swift
//  RealStory
//
//  Created by Eric Hong Tuan Ha on 28/04/2025.
//

import SwiftUI
 
class JsonService {
    private static var usersJson : UsersJson = .load(filename: "users.json")
    static var pageList : [Page]{
        usersJson.pages
    }
    static var userList : [User]{
        usersJson.pages.reduce([]) { partialResult, page in
            partialResult + page.users
        }
    }
}

private struct UsersJson : Hashable, Codable {
    let pages : [Page]
}

private extension Decodable{
    static func load<T: Decodable>( filename: String) -> T {
        guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
            else {
                fatalError("Couldn't find \(filename) in main bundle.")
        }
        let data: Data
        do {
            data = try Data(contentsOf: file)
        } catch {
            fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
        }
        do {
            let decoder = JSONDecoder()
            return try decoder.decode(T.self, from: data)
        } catch {
            fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
        }
    }
}

