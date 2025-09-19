//
//  GuessSettingView.swift
//  Wizard Helper
//
//  Created by Alexandra Zwinger on 17.09.25.
//

import SwiftUI

struct GuessSettingView: View {
    @EnvironmentObject var userData: UserData
    @Environment(\.dismiss)
    var dismiss
    @State private var selection = 0
    @State private var showNextView: Bool = false
    var body: some View {
        ZStack {
            BackgroundView()
            TabView(selection: $selection) {
                let rotatedUsers = (0..<userData.users.count).map { i in
                    let index = (i + (userData.currentRound ?? 1) - 1) % userData.users.count
                    return userData.users[index]
                }

                ForEach(rotatedUsers.indices, id: \.self) { index in
                    SetGuessView(
                        user: rotatedUsers[index],
                        stingCount: String(rotatedUsers[index].currentGuess ?? 0),
                        backAction: {
                            if selection == 0 {
                                dismiss()
                            } else {
                                selection -= 1
                            }
                        },
                        forwardAction: {
                            if selection >= userData.users.count - 1 {
                                showNextView = true
                            } else {
                                selection += 1
                            }
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
}

struct StingSettingView_Previews: PreviewProvider {
    static var previews: some View {
        let testData = UserData()
        testData.users = [
            User(name: "Peter"),
            User(name: "Anna")
        ]
        return GuessSettingView()
            .environmentObject(testData)
    }
}
