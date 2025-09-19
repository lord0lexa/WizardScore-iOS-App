//
//  Wizard_HelperApp.swift
//  Wizard Helper
//
//  Created by Alexandra Zwinger on 17.09.25.
//

import SwiftUI

@main
struct Wizard_HelperApp: App {
    @StateObject var userData = UserData()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(userData)
        }
    }
}
