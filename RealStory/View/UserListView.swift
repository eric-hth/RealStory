//
//  UserListView.swift
//  RealStory
//
//  Created by Eric Hong Tuan Ha on 28/04/2025.
//
import SwiftUI

struct UserListView: View {
    let userList : [User]
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(userList) { user in
                    UserRoundImage(user: user).padding(3)
                }
            }
        }
    }
}


struct UserView : View {
    let user : User
    var body: some View {
        HStack{
            AsyncImage(url: user.profile_picture_url)
            .aspectRatio(contentMode: .fill)
            .frame(width: 40, height: 40)
            .clipShape(Circle())
            Text(user.name).foregroundStyle(.white)
        }
    }
}

struct UserRoundImage: View {
      let user : User
    var body: some View {
        AsyncImage(url: user.profile_picture_url)
            .frame(width: 55, height: 55, alignment: .trailing)
            .clipShape(Circle())
            .padding(7)
            .overlay(Circle().stroke( LinearGradient.instagramCircle, style: StrokeStyle(lineWidth: 2.5, lineCap: .round)) )
    }
}
private extension LinearGradient {
    static var instagramCircle : LinearGradient {
        LinearGradient( gradient: Gradient(colors: [.yellow, .red, .purple, .orange, .pink, .red]), startPoint: .bottomLeading, endPoint: .topTrailing)
    }
}


struct AsyncImage : View {
    let url : String
    var body: some View {
        HStack{
            SwiftUI.AsyncImage(url: URL(string:url)) { phase in
                switch phase {
                    case .failure:
                        Image(systemName: "photo")
                            .font(.largeTitle)
                    case .success(let image):
                        image
                            .resizable()
                default:
                    ProgressView()
                }
            }
        }
    }
}
