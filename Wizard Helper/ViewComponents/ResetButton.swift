//
//  ResetButton.swift
//  Wizard Helper
//
//  Created by Alexandra Zwinger on 19.09.25.
//

import SwiftUI

struct ResetButton: View {
    @EnvironmentObject var userData: UserData
    @State private var showAlert: Bool = false
    @State private var showStartView: Bool = false
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Image(systemName: "arrow.trianglehead.counterclockwise")
                    .resizable()
                    .frame(width: 32, height: 32)
                    .foregroundStyle(.white)
                    .onTapGesture {
                        showAlert = true
                    }
                    .padding(8)
                
            }
            Spacer()
        }
        .fullScreenCover(isPresented: $showStartView) {
            ContentView()
        }
        .alert(isPresented: $showAlert) {
            return Alert(
                title: Text("Spiel zurücksetzen"),
                message: Text("sichi?"),
                primaryButton:
                        .destructive(Text("Daten löschen")) {
                            userData.resetGame()
                            showStartView = true
                        },
                secondaryButton: .cancel(Text("Abbrechen"))
            )
        }
    }
}
