//
//  Player.swift
//  Wizard Helper
//
//  Created by Alexandra Zwinger on 17.09.25.
//

import Foundation
import SwiftUI
import Combine

struct Player: Identifiable, Codable {
    var id = UUID()
    var name: String
    var currentGuess: Int?
    var currentStings: Int?
    var pointHistory: [Int: Int] = [:]
    var overallPoints: Int {
        pointHistory.values.reduce(0, +)
    }
}

enum Trump: Codable {
    case none
    case elves
    case humans
    case giants
    case dwarves
    
    var image: Image {
        switch self {
        case .none: return Image(systemName: "xmark")
        case .elves: return Image("elves")
        case .humans: return Image("humans")
        case .giants: return Image("giants")
        case .dwarves: return Image("dwarves")
        }
    }
}

class UserData: ObservableObject {
    @Published var player: [Player] = [Player(name: "")] { didSet { save() } }
    @Published var currentTrump: Trump? { didSet { save() } }
    @Published var currentRound: Int? { didSet { save() } }
    
    private let key = "userData"
    
    init() {
        load()
    }

    private func save() {
        let snapshot = Snapshot(
            player: player,
            currentTrump: currentTrump,
            currentRound: currentRound
        )
        if let encoded = try? JSONEncoder().encode(snapshot) {
            UserDefaults.standard.set(encoded, forKey: key)
        }
    }
    
    private func load() {
        if let data = UserDefaults.standard.data(forKey: key),
           let snapshot = try? JSONDecoder().decode(Snapshot.self, from: data) {
            self.player = snapshot.player
            self.currentTrump = snapshot.currentTrump
            self.currentRound = snapshot.currentRound
        } else {
            self.player = [Player(name: "")]
            self.currentTrump = nil
            self.currentRound = nil
        }
    }
    
    private struct Snapshot: Codable {
        var player: [Player]
        var currentTrump: Trump?
        var currentRound: Int?
    }
    
    func resetGame() {
        player = [Player(name: "")]
        currentRound = nil
        currentTrump = nil
    }
    
    var summedUpStings: Int {
        let sum = player
            .map { $0.currentGuess ?? 0 }
            .reduce(0, +)
        if let currentRound {
            return currentRound - sum
        }
        return 0
    }
}
