//
//  AggregatedFeelingModel.swift
//  Nogent
//
//  Created by Tinashe Makuti on 04/02/2023.
//

import Foundation

struct AggregatedFeelingModel: Hashable {
    let id: UUID = UUID()
    let label: String
    let value: CGFloat
}

