//
//  GuessOverviewView.swift
//  Wizard Helper
//
//  Created by Alexandra Zwinger on 17.09.25.
//

import SwiftUI

struct GuessOverviewView: View {
    @EnvironmentObject var userData: UserData
    @State private var showNextView: Bool = false
    var body: some View {
        ZStack {
            BackgroundView()
            VStack {
                Spacer()
                Text("Runde " + String(userData.currentRound ?? 0))
                HStack {
                    Text("Trumpf: ")
                    userData.currentTrump?.image
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30, height: 30)
                }
                ForEach(userData.users, id: \.id) { user in
                    HStack(spacing: 10) {
                        Text(user.name + ":")
                        Text("\(user.currentGuess ?? 0)")
                    }
                }
                Text("Übrig: " + "\(userData.summedUpStings)")
                Spacer()
                GoButton(label: "Punkte eintragen ->") {
                    showNextView = true
                }
            }
            ResetButton()
        }
        .font(.title)
        .foregroundStyle(.white)
        .fullScreenCover(isPresented: $showNextView) {
            StingSettingView()
        }
    }
}
