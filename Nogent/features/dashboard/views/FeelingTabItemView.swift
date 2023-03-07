//
//  DateFeelingTabItemView.swift
//  Nogent
//
//  Created by Tinashe Makuti on 04/02/2023.
//

import SwiftUI

struct FeelingTabItemView: View {
    var currentFeeling: FeelingModel
    var isSelected: Bool = false
    
    init(currentFeeling: FeelingModel, isSelected: Bool) {
        self.currentFeeling = currentFeeling
        self.isSelected = isSelected
    }
    
    var body: some View {
        VStack {
            VStack(spacing: 8) {
                Text(DateUtils.formatDate(date: currentFeeling.date, format: "EEE"))
                    .foregroundColor(isSelected ? .white : .secondary)
                
                Text(DateUtils.formatDate(date: currentFeeling.date, format: "dd"))
                    .font(.title3)
                    .foregroundColor(isSelected ? .white : .primary)
                    .fontWeight(.bold)
            }
            .foregroundColor(.white)
            .padding()
            .background(
                ZStack {
                    Rectangle().fill(
                        isSelected ? Color.accentColor : .secondary.opacity(0)
                    ).cornerRadius(16)
                }
            )
            
            if isSelected {
                Image(currentFeeling.feeling.rawValue)
                    .resizable()
                    .frame(width: 32, height: 32)
            } else {
                Spacer()
            }
        }
    }
}

struct FeelingTabItemView_Previews: PreviewProvider {
    static var previews: some View {
        FeelingTabItemView(currentFeeling:
                .init(feeling: FeelingEnum.neutral, reason: "Someone made me happy", date: Date()), isSelected: true)
        
    }
}
