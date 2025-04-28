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
                ForEach(storyListViewModel.storyList) { story in
                    UserRoundImage(user: story.user).padding(3).onTapGesture {
                        storyListViewModel.topViewSelectStory(story)
                    }
                }
            }
        }
    }
}

private struct UserRoundImage: View {
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
