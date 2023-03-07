//
//  LogFeelingViewModel.swift
//  Nogent
//
//  Created by Tinashe Makuti on 06/02/2023.
//

import SwiftUI
import CoreData

@MainActor
class LogFeelingViewModel: ObservableObject {
    
    let container: NSPersistentContainer
    
    @Published var message: String = ""
    @Published var selectedFeeling: SelectableFeelingItemModel? = nil
    
    init(container: NSPersistentContainer = .init(name: "Nogent")) {
        self.container = container
        self.container.loadPersistentStores { (description, error) in
            if let error = error {
                print("Error loading core data \(error)")
            }
        }
    }

    func cacheFeeling() {
        withAnimation {
            let cachedFeeling = FeelingEntity(context: container.viewContext)
            cachedFeeling.createdAt = Date()
            cachedFeeling.name = selectedFeeling?.title.rawValue
            cachedFeeling.reason = message

            do {
                try container.viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }

}
