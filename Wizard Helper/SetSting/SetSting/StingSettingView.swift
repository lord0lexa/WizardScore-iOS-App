//
//  StingSettingView.swift
//  Wizard Helper
//
//  Created by Alexandra Zwinger on 18.09.25.
//

import SwiftUI

struct StingSettingView: View {
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
                let rotatedUsers = (0..<userData.users.count).map { i in
                    let index = (i + (userData.currentRound ?? 1) - 1) % userData.users.count
                    return userData.users[index]
                }
                ForEach(rotatedUsers.indices, id: \.self) { index in
                    let user = rotatedUsers[index]
                    SetStingView(
                        user: user,
                        stingCount: String(user.currentGuess ?? 0),
                        backAction: {
                            if selection == 0 {
                                dismiss()
                            } else {
                                selection -= 1
                            }
                        },
                        forwardAction: {
                            if selection >= userData.users.count - 1 {
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
                    message: Text("Bitte überprüfe die Stichzahl für jeden Spieler (\(userData.currentRound ?? 0 - userData.summedUpStings))"),
                    dismissButton: .default(Text("Ok"))
                )
            }
            ResetButton()
        }
    }
    
    private func checkValidStingCount() -> Bool {
        var totalStingCount = 0
        for index in userData.users.indices {
            let user = userData.users[index]
            totalStingCount += user.currentStings ?? 0
        }
        return totalStingCount == userData.currentRound
    }
    
    private func calculatePoints(){
        for index in userData.users.indices {
            let user = userData.users[index]
            var points = 20
            if let guess = user.currentGuess {
                if let stings = user.currentStings {
                    if guess != user.currentStings {
                        let diff = guess - stings
                        points = -(abs(diff) * 10)
                    } else {
                        points = 20 + stings * 10
                    }
                }
            }
            userData.users[index].pointHistory[userData.currentRound ?? 1] = points
        }
    }
}
