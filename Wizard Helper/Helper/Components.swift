//
//  Buttond.swift
//  Wizard Helper
//
//  Created by Alexandra Zwinger on 17.09.25.
//

import SwiftUI

struct GoButton: View {
    var label: String
    var action: () -> Void
    var body: some View {
        Button(label) {
            action()
        }
        .font(Font.title.bold())
        .padding()
    }
}

struct RoundButton: View {
    var icon: Image
    var action: () -> Void
    var body: some View {
        ZStack {
            icon
            Circle().stroke(Color.white, lineWidth: 2)
                .frame(width: 40, height: 40)
        }
        .onTapGesture {
            withAnimation {
                action()
            }
        }
    }
}

struct Textfield: View {
    @Binding var text: String
    var body: some View {
        TextField(
                "",
                text: $text
            )
            .font(.system(size: 25))
            .frame(height: 40)
            .disableAutocorrection(true)
            .background(Color.gray)
            .opacity(0.5)
            .padding(5)
    }
}

struct Numberfield: View {
    @Binding var text: String
    var body: some View {
        TextField(
                "",
                text: $text
            )
            .font(.system(size: 25))
            .frame(height: 40)
            .disableAutocorrection(true)
            .padding(5)
            .background(Color.gray)
            .opacity(0.5)
            .keyboardType(.numberPad)
            .onChange(of: text) {
                text = text.filter { "0123456789".contains($0) }
            }
    }
}

struct TrumpButton: View {
    var icon: Image
    var smaller: Bool?
    var action: () -> Void
    var body: some View {
        ZStack {
            icon
                .resizable()
                .scaledToFit()
                .frame(height: smaller ?? false ? 85 : 130)
                .padding(10)
                .foregroundStyle(Color.gray)
        }
        .onTapGesture { action() }
        .padding(15)
    }
}

#Preview("Go") {
    GoButton(label: "Go"){}
}

#Preview("Round") {
    RoundButton(icon: Image(systemName: "plus")){}
}

#Preview("Trump") {
    TrumpButton(icon: Image(systemName: "plus")){}
}

