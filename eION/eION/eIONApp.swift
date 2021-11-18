//
//  eIONApp.swift
//  eION
//
//  Created by Guillermo Montalban Martinez on 18/11/21.
//

import SwiftUI

@main
struct eIONApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
