//
//  SetStingView.swift
//  Wizard Helper
//
//  Created by Alexandra Zwinger on 18.09.25.
//

import SwiftUI

struct SetStingView: View {
    @EnvironmentObject var userData: UserData
    @Environment(\.dismiss)
    var dismiss
    @State private var selection = 0
    @State private var showNextView: Bool = false
    @State private var showAlert: Bool = false
    var body: some View {
        ZStack {
            BackgroundView()
            TabView(selection: $selection) {
                ForEach(Array(rotatedUsers.enumerated()), id: \.element.id) { (index, player) in
                    SetStingPage(
                        player: player,
                        stingCount: String(player.currentGuess ?? 0),
                        backwardAction: { backwardAction() },
                        forwardAction: { forwardAction() }
                    )
                    .tag(index)
                }
            }
            .ignoresSafeArea(.all)
            .tabViewStyle(.page(indexDisplayMode: .never))
            .fullScreenCover(isPresented: $showNextView) {
                PointOverviewView()
            }
            .alert(isPresented: $showAlert) {
                return Alert(
                    title: Text("Stichzahl stimmt nicht"),
                    message: Text("Bitte überprüfe die Stichzahl für jeden Spieler (\((userData.currentRound ?? 1) - userData.summedUpStings) statt \(userData.currentRound ?? 1))"),
                    dismissButton: .default(Text("Ok"))
                )
            }
            ResetButton()
        }
    }
    
    var rotatedUsers: [Player] {
            guard !userData.player.isEmpty else { return [] }
            return (0..<userData.player.count).map { i in
                let index = (i + (userData.currentRound ?? 1) - 1) % userData.player.count
                return userData.player[index]
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
            if !checkValidStingCount() {
                showAlert = true
                return
            }
            calculatePoints()
            showNextView = true
        } else {
            selection += 1
        }
    }
    
    private func checkValidStingCount() -> Bool {
        var totalStingCount = 0
        for index in userData.player.indices {
            let user = userData.player[index]
            totalStingCount += user.currentStings ?? 0
        }
        return totalStingCount == userData.currentRound
    }
    
    private func calculatePoints(){
        for index in userData.player.indices {
            let player = userData.player[index]
            var points = 20
            if let guess = player.currentGuess {
                if let stings = player.currentStings {
                    if guess != player.currentStings {
                        let diff = guess - stings
                        points = -(abs(diff) * 10)
                    } else {
                        points = 20 + stings * 10
                    }
                }
            }
            userData.player[index].pointHistory[userData.currentRound ?? 1] = points
        }
    }
}
