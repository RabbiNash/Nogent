//
//  FeelingLogItem.swift
//  Nogent
//
//  Created by Tinashe Makuti on 06/02/2023.
//

import SwiftUI

struct LogFeelingItemView: View {
    var item: SelectableFeelingItemModel
    
    var body: some View {
        VStack {
            Image(item.image)
                .resizable()
                .frame(width: 48, height: 48)
            
            Text(item.title.rawValue.capitalized)
                .font(.subheadline)
                .lineLimit(1)
        }
        .padding(24)
    }
}

struct LogFeelingItemView_Previews: PreviewProvider {
    static var previews: some View {
        LogFeelingItemView(item: .availableFeelings.first!)
    }
}
