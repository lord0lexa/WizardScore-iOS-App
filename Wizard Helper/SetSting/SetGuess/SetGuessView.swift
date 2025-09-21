//
//  SetGuessView.swift
//  Wizard Helper
//
//  Created by Alexandra Zwinger on 17.09.25.
//

import SwiftUI

struct SetGuessView: View {
    @EnvironmentObject var userData: UserData
    @Environment(\.dismiss)
    var dismiss
    @State private var selection = 0
    @State private var showNextView: Bool = false
    var body: some View {
        ZStack {
            BackgroundView()
            TabView(selection: $selection) {
                let rotatedUsers = (0..<userData.player.count).map { i in
                    let index = (i + (userData.currentRound ?? 1) - 1) % userData.player.count
                    return userData.player[index]
                }
                ForEach(rotatedUsers.indices, id: \.self) { index in
                    SetGuessPage(
                        player: rotatedUsers[index],
                        stingCount: String(rotatedUsers[index].currentGuess ?? 0),
                        backwardAction: {
                            backwardAction()
                        },
                        forwardAction: {
                            forwardAction()
                        }
                    )
                        .tag(index)
                }
            }
            .ignoresSafeArea(.all)
            .tabViewStyle(.page(indexDisplayMode: .never))
            .fullScreenCover(isPresented: $showNextView) {
                GuessOverviewView()
            }
            ResetButton()
        }
    }
    
    private func backwardAction() {
        if selection == 0 {
            dismiss()
        } else {
            selection -= 1
        }
    }
    
    private func forwardAction() {
        if selection >= userData.player.count - 1 {
            showNextView = true
        } else {
            selection += 1
        }
    }
}

struct StingSettingView_Previews: PreviewProvider {
    static var previews: some View {
        let testData = UserData()
        testData.player = [
            Player(name: "Peter"),
            Player(name: "Anna")
        ]
        return SetGuessView()
            .environmentObject(testData)
    }
}
