//
//  BackgroundView.swift
//  Wizard Helper
//
//  Created by Alexandra Zwinger on 17.09.25.
//

import SwiftUI

struct BackgroundView: View {
    var body: some View {
        ZStack {
            Image("Background")
                .resizable()
                .ignoresSafeArea()
            Color.black.opacity(0.6)
                .ignoresSafeArea()
        }
    }
}

#Preview {
    BackgroundView()
}
