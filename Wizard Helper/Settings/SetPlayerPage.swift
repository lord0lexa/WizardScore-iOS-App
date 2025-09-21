//
//  SetPlayerPage.swift
//  Wizard Helper
//
//  Created by Alexandra Zwinger on 17.09.25.
//

import SwiftUI

struct SetPlayerPage: View {
    @Binding var newPlayer: String
    var player: [String]
    var addAction: () -> Void
    var removeAction: () -> Void
    var nextAction: () -> Void
    var body: some View {
        VStack {
            Spacer()
            Text("Lehrlinge angeben")
                .font(Font.largeTitle.bold())
            ForEach(player.indices, id: \.self) { index in
                Text(player[index])
            }
            
            inputBar
            Spacer()
            GoButton(label: "Fertig") { nextAction() }
                .disabled(player.count < 3 || newPlayer.isEmpty)
        }
        .padding(20)
        .foregroundStyle(Color.white)
    }
    
    private var inputBar: some View {
        HStack(spacing: 5) {
            RoundButton(icon: Image(systemName: "minus")) {
                if player.count == 1 {
                    newPlayer = ""
                } else {
                    removeAction()
                }
            }
            Textfield(text: $newPlayer)
            RoundButton(icon: Image(systemName: "plus")) {
                if newPlayer.isEmpty { return }
                addAction()
            }
            .disabled(player.count >= 6)
        }
    }
}
