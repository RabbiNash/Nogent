//
//  SelectableFeelingItemModel.swift
//  Nogent
//
//  Created by Tinashe Makuti on 06/02/2023.
//

import Foundation

struct SelectableFeelingItemModel: Hashable {
    let id: UUID = UUID()
    let image: String
    let title: FeelingEnum
    
    static let availableFeelings: [SelectableFeelingItemModel] = [
        .init(image: FeelingEnum.happy.rawValue, title: .happy),
        .init(image: FeelingEnum.confused.rawValue, title: .confused),
        .init(image: FeelingEnum.neutral.rawValue, title: .neutral),
        .init(image: FeelingEnum.cool.rawValue, title: .cool),
        .init(image: FeelingEnum.sad.rawValue, title: .sad),
    ]
}
