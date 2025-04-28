//
//  StoryListTopView.swift
//  RealStory
//
//  Created by Eric Hong Tuan Ha on 28/04/2025.
//
import SwiftUI

struct StoryListTopView: View {
    @ObservedObject var storyListViewModel : StoryListViewModel
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                if let storyList = storyListViewModel.storyList{
                    ForEach(storyList) { story in
                        UserRoundImage(user: story.user, seen: story.seen).padding(3).onTapGesture {
                            storyListViewModel.topViewSelectStory(story)
                        }
                    }
                }

            }
        }
    }
}

private struct UserRoundImage: View {
      let user : User
    let seen : Bool
    var body: some View {
        AsyncImage(url: user.profile_picture_url)
            .frame(width: 55, height: 55, alignment: .trailing)
            .clipShape(Circle())
            .padding(7)
            .modifier(UserRoundImageCircle(seen: seen))
    }
}

struct UserRoundImageCircle: ViewModifier {
    let seen : Bool
    func body(content: Content) -> some View {
        if seen{
            content
                .overlay(Circle().stroke( .gray, style: StrokeStyle(lineWidth: 2.5, lineCap: .round)) )
        }
        else{
            content
                .overlay(Circle().stroke( LinearGradient.instagramCircle, style: StrokeStyle(lineWidth: 2.5, lineCap: .round)) )
        }
    }
}

private extension LinearGradient {
    static var instagramCircle : LinearGradient {
        LinearGradient( gradient: Gradient(colors: [.yellow, .red, .purple, .orange, .pink, .red]), startPoint: .bottomLeading, endPoint: .topTrailing)
    }
}
