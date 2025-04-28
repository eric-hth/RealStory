//
//  StoryView.swift
//  RealStory
//
//  Created by Eric Hong Tuan Ha on 28/04/2025.
//
import SwiftUI

struct StoryView : View {
    let story : Story
    let onClose : () -> Void
    var body: some View {
        GeometryReader { proxy in
            ZStack{
                AsyncImage(url: story.imageList[0].url).aspectRatio(contentMode: .fit)
                VStack{
                    HStack{
                        StoryUserView(user: story.user, onClose: onClose).padding(10)
                        Spacer()
                    }
                    Spacer()
                }
            }
            .padding(.bottom,20)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            .rotation3DEffect(
                .rotation3DAngle(proxy: proxy),
                axis: (x: 0, y: 1, z: 0),
                anchor: proxy.frame(in: .global).minX > 0 ? .leading : .trailing,
                perspective: 2.5)
        }
    }
}

private extension Angle{
    static func rotation3DAngle( proxy : GeometryProxy) -> Angle{
        Angle(degrees: 45 * proxy.frame(in: .global).minX / proxy.size.width)
    }
}
 

struct StoryUserView : View {
    let user : User
    let onClose : () -> Void
    var body: some View {
        HStack{
            AsyncImage(url: user.profile_picture_url)
            .aspectRatio(contentMode: .fill)
            .frame(width: 40, height: 40)
            .clipShape(Circle())
            Text(user.name).foregroundStyle(.white)
            Spacer()
            Image(systemName:"xmark").font(.system(size: 16)).foregroundColor(.white).onTapGesture {
                onClose()
            }
        }
    }
}
