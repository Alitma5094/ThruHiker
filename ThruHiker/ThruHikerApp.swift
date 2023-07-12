//
//  ThruHikerApp.swift
//  ThruHiker
//
//  Created by Drew Litman on 6/7/23.
//

import SwiftUI

@main
struct ThruHikerApp: App {
    @StateObject private var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
