//
//  EndView.swift
//  Wizard Helper
//
//  Created by Alexandra Zwinger on 19.09.25.
//

import SwiftUI

struct EndView: View {
    @EnvironmentObject var userData: UserData
    @State private var showNextView: Bool = false
    var body: some View {
        ZStack {
            BackgroundView()
            VStack {
                HStack {
                    VStack {
                        Text("-")
                        ForEach(1...(userData.currentRound ?? 1), id: \.self) { index in
                            Text("\(index)")
                        }
                        Text("----")
                        Text("/")
                    }
                    ForEach(userData.users, id: \.id) { user in
                        VStack {
                            Text(user.name)
                                .lineLimit(1)
                            ForEach(Array(user.pointHistory.keys.sorted()), id: \.self) { round in
                                let value = user.pointHistory[round] ?? 0
                                let display = value > 0 ? "+\(value)" : "\(value)"
                                
                                Text(display)
                            }
                            Text("----")
                            Text(String(user.overallPoints))
                        }
                    }
                }
                .font(.title)

                RankView()
            }
            ResetButton()
        }
        .foregroundStyle(.white)
    }
}
