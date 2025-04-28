//
//  ContentView.swift
//  RealStory
//
//  Created by Eric Hong Tuan Ha on 28/04/2025.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        VStack {
            UserListView(userList: JsonService.userList)
                .padding(.top,10)
            Spacer()
        }
    }
}
