//
//  ThruHikerApp.swift
//  ThruHiker
//
//  Created by Drew Litman on 6/7/23.
//

import SwiftUI
import SwiftData

@main
struct ThruHikerApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: [Journey.self, TrailLocationSave.self])
        }
    }
}
