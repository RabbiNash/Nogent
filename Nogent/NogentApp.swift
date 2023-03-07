//
//  NogentApp.swift
//  Nogent
//
//  Created by Tinashe Makuti on 04/02/2023.
//

import SwiftUI

@main
struct NogentApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            DashboardView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
