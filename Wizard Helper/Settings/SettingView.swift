//
//  SettingView.swift
//  Wizard Helper
//
//  Created by Alexandra Zwinger on 17.09.25.
//

import SwiftUI

struct SettingView: View {
    @EnvironmentObject var userData: UserData
    @State private var selection = 0
    @State private var showNextView: Bool = false
    var body: some View {
        ZStack {
            BackgroundView()
            TabView(selection: $selection) {
                ForEach(userData.users.indices, id: \.self) { index in
                    AddPlayerView(
                        newUser: $userData.users[index].name,
                        users: userData.users.map { $0.name },
                        addAction: {
                            userData.users.append(User(name: ""))
                            selection = userData.users.count - 1
                        },
                        removeAction: {
                            updateSelection()
                            userData.users.remove(at: selection)
                            selection = selection - 1
                        },
                        nextAction: {
                            userData.currentRound = 1
                            showNextView = true
                        }
                    )
                    .tag(index)
                }
            }
            .onAppear(perform: updateSelection)
            .tabViewStyle(.page(indexDisplayMode: .never))
            .fullScreenCover(isPresented: $showNextView) {
                SelectTrumpView()
            }
        }
    }
    
    private func updateSelection() {
        if let last = userData.users.indices.last {
            selection = last
        }
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        let testData = UserData()
        testData.users = [
            User(name: "Peter"),
            User(name: "Anna")
        ]
        return SettingView()
            .environmentObject(testData)
    }
}
