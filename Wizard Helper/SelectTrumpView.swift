//
//  SelectTrumpView.swift
//  Wizard Helper
//
//  Created by Alexandra Zwinger on 17.09.25.
//

import SwiftUI

struct SelectTrumpView: View {
    @EnvironmentObject var userData: UserData
    @State private var showNextView: Bool = false

    var body: some View {
        ZStack {
            BackgroundView()
            VStack {
                Text("Runde " + String(userData.currentRound ?? 0))
                    .foregroundStyle(.white)
                TrumpButton(icon: Trump.humans.image) {
                    selectTrump(.humans)
                }
                HStack {
                    TrumpButton(icon: Trump.elves.image) {
                        selectTrump(.elves)
                    }
                    TrumpButton(icon: Trump.none.image, smaller: true) {
                        selectTrump(.none)
                    }
                    TrumpButton(icon: Trump.dwarves.image) {
                        selectTrump(.dwarves)
                    }
                }
                TrumpButton(icon: Trump.giants.image) {
                    selectTrump(.giants)
                }
            }
            .fullScreenCover(isPresented: $showNextView) {
                GuessSettingView()
            }
            ResetButton()
        }
    }
    
    private func selectTrump(_ trump: Trump) {
        userData.currentTrump = trump
        showNextView = true
    }
}

struct SelectTrumpView_Previews: PreviewProvider {
    static var previews: some View {
        let testData = UserData()
        testData.users = [
            User(name: "Peter"),
            User(name: "Anna")
        ]
        return SelectTrumpView()
            .environmentObject(testData)
    }
}
