//
//  RankView.swift
//  Wizard Helper
//
//  Created by Alexandra Zwinger on 19.09.25.
//

import SwiftUI

struct RankView: View {
    @EnvironmentObject var userData: UserData
    var body: some View {
        let sortedUsers = userData.users.sorted { lhs, rhs in
            if lhs.overallPoints == rhs.overallPoints {
                return lhs.name.localizedCompare(rhs.name) == .orderedAscending
            } else {
                return lhs.overallPoints > rhs.overallPoints
            }
        }
        
        VStack(alignment: .leading) {
            ForEach(sortedUsers) { user in
                Text("\(user.name): \(user.overallPoints)")
                    .font(.title)
            }
        }
    }

}
