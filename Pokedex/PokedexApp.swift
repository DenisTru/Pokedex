//
//  PokedexApp.swift
//  Pokedex
//
//  Created by Denis Truong on 11/16/21.
//

import SwiftUI

@main
struct PokedexApp: App {
    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
