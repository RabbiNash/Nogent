//
//  DashboardViewModel.swift
//  Nogent
//
//  Created by Tinashe Makuti on 06/02/2023.
//

import SwiftUI
import CoreData

class DashboardViewModel: ObservableObject {
    
    let container: NSPersistentContainer
    @Published var feelings: [FeelingModel] = []
    @Published var selectedFeeling: FeelingModel? = nil
    @Published var scrollTarget: FeelingModel? = nil
    @Published var aggregatedFeelings: [AggregatedFeelingModel] = []
    @Published var logFeeling: Bool = false
    
    init(container: NSPersistentContainer = .init(name: "Nogent")) {
        self.container = container
        self.container.loadPersistentStores { (description, error) in
            if let error = error {
                print("Error loading core data \(error)")
            }
        }
        self.container.viewContext.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump
        fetchCachedFeelings()
        NotificationManager.instance.requestAuthorization()
    }
    
    func fetchCachedFeelings() {
        let request = NSFetchRequest<FeelingEntity>(entityName: "FeelingEntity")
        
        do {
            let cachedFeelings = try container.viewContext.fetch(request)
            feelings = cachedFeelings.map { item in
                FeelingModel(feeling: FeelingEnum(rawValue: item.name!) ?? .cool, reason: item.reason, date: item.createdAt!)
            }
            scrollTarget = feelings.last
            selectedFeeling = feelings.last
            aggregatedFeelings = getAggregatedFeelings(feelings: feelings)
        } catch let error {
            print("Error fetching \(error)")
        }
    }
    
    private func getAggregatedFeelings(feelings: [FeelingModel]) -> [AggregatedFeelingModel] {
        var aggregatedFeelings: [AggregatedFeelingModel] = []
        let groupedFeelings = Dictionary(grouping: feelings, by: { $0.feeling.rawValue })
        
        for feeling in groupedFeelings {
            aggregatedFeelings.append(.init(label: feeling.key, value: CGFloat(feeling.value.endIndex + 1)))
        }
        
        return aggregatedFeelings
    }
}
