//
//  AddPlayerView.swift
//  Wizard Helper
//
//  Created by Alexandra Zwinger on 17.09.25.
//

import SwiftUI

struct AddPlayerView: View {
    @Binding var newUser: String
    var users: [String]
    var addAction: () -> Void
    var removeAction: () -> Void
    var nextAction: () -> Void
    var body: some View {
            VStack {
                Spacer()
                Text("Lehrlinge angeben")
                    .font(Font.largeTitle.bold())
                ForEach(users.indices, id: \.self) { index in
                    Text(users[index])
                }

                HStack(spacing: 5) {
                    RoundButton(icon: Image(systemName: "minus")) {
                        if users.count == 1 {
                            newUser = ""
                        } else {
                            removeAction()
                        }
                    }
                    Textfield(text: $newUser)
                    RoundButton(icon: Image(systemName: "plus")) {
                        if newUser.isEmpty { return }
                        addAction()
                    }
                        .disabled(users.count >= 6)
                }
                Spacer()
                GoButton(label: "Fertig") { nextAction() }
                    .disabled(users.count < 3 || newUser.isEmpty)
            }
            .padding(20)
            .foregroundStyle(Color.white)
        }
}
