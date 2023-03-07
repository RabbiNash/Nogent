//
//  FeelingModel.swift
//  Nogent
//
//  Created by Tinashe Makuti on 04/02/2023.
//

import Foundation

struct FeelingModel: Identifiable, Hashable {
    let id: UUID = UUID()
    let feeling: FeelingEnum
    let reason: String?
    let date: Date
    
    static let sampleFeelings: [FeelingModel] = [
        .init(feeling: .neutral, reason: "Someone made me neutral", date: Date.getDate(minus: -7)),
        .init(feeling: .sad, reason: "Someone made me very sad", date: Date.getDate(minus: -6)),
        .init(feeling: .tired, reason: "Someone made me happy", date: Date.getDate(minus: -5)),
        .init(feeling: .confused, reason: "Someone made me confused", date: Date.getDate(minus: -4)),
        .init(feeling: .sad, reason: "Someone made me sad", date: Date.getDate(minus: -3)),
        .init(feeling: .pissed, reason: "Someone made me neutrtal", date: Date.getDate(minus: -2)),
        .init(feeling: .happy, reason: "Someone made me happy, Before Swift 5.5, if we wanted to make an enum that contains associated values conform to Codable, then we’d have to write all of that code manually. However, that’s no longer the case, as the compiler has received an upgrade that now makes it capable of auto-synthesizing serialization code for such enums as well.", date: Date.getDate(minus: -1)),
        .init(feeling: .relaxed, reason: nil, date: Date.now),
    ]

}

