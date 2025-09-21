//
//  ContentView.swift
//  Wizard Helper
//
//  Created by Alexandra Zwinger on 17.09.25.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var userData: UserData
    @State private var showNextView: Bool = false
    var body: some View {
        ZStack {
            BackgroundView()
            VStack {
                Spacer()
                Text("WIZARD SCOREBOARD")
                    .font(Font.largeTitle.bold())
                Spacer()
                GoButton(label: "Los geht's!") {
                    showNextView = true
                }
            }
            .foregroundStyle(Color.white)
        }
        .fullScreenCover(isPresented: $showNextView) {
            if userData.currentRound == nil {
                SetPlayerView()
            } else {
                SelectTrumpView()
            }
        }
    }
}

#Preview {
    ContentView()
}
