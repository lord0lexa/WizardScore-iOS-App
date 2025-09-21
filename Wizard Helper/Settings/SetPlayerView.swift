//
//  SetPlayerView.swift
//  Wizard Helper
//
//  Created by Alexandra Zwinger on 17.09.25.
//

import SwiftUI

struct SetPlayerView: View {
    @EnvironmentObject var userData: UserData
    @State private var selection = 0
    @State private var showNextView: Bool = false
    var body: some View {
        ZStack {
            BackgroundView()
            TabView(selection: $selection) {
                ForEach(userData.player.indices, id: \.self) { index in
                    SetPlayerPage(
                        newUser: $userData.player[index].name,
                        player: userData.player.map { $0.name },
                        addAction: {
                            addAction()
                        },
                        removeAction: {
                            removeAction()
                        },
                        nextAction: {
                            nextAction()
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
        if let last = userData.player.indices.last {
            selection = last
        }
    }
    
    private func addAction() {
        userData.player.append(Player(name: ""))
        selection = userData.player.count - 1
    }
    
    private func removeAction() {
        updateSelection()
        userData.player.remove(at: selection)
        selection = selection - 1
    }
    
    private func nextAction() {
        userData.currentRound = 1
        showNextView = true
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        let testData = UserData()
        testData.player = [
            Player(name: "Peter"),
            Player(name: "Anna")
        ]
        return SetPlayerView()
            .environmentObject(testData)
    }
}
