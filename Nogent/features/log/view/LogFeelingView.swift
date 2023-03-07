//
//  LogFeelingView.swift
//  Nogent
//
//  Created by Tinashe Makuti on 06/02/2023.
//

import SwiftUI

struct LogFeelingView: View {
    @FocusState private var isFieldInFocus: Bool
    @Environment(\.dismiss) var dismiss
    @StateObject private var viewModel: LogFeelingViewModel = .init()
    
    var body: some View {
            ScrollView {
                VStack {
                    Text("Which of the following best describes how you are feeling today?")
                        .padding(.top)
                        .font(.headline)
                    
                    LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 10), count: 3)) {
                        ForEach(SelectableFeelingItemModel.availableFeelings, id: \.self) { item in
                            LogFeelingItemView(item: item)
                                .onTapGesture {
                                    withAnimation {
                                        viewModel.selectedFeeling = item
                                        isFieldInFocus = true
                                    }
                                }.overlay(
                                    viewModel.selectedFeeling?.id == item.id ?  Circle().stroke(Color.accentColor) : nil
                                )
                        }
                    }
                    
                    Spacer()
                    
                    if viewModel.selectedFeeling != nil {
                        HStack {
                            ZStack {
                                TextEditorView(string: $viewModel.message)
                                    .focused($isFieldInFocus)
                                
                                if $viewModel.message.wrappedValue.isEmpty {
                                    Text("Reason..")
                                        .foregroundColor(.primary.opacity(0.6))
                                        .padding(.horizontal, 8)
                                        .padding(.vertical, 12)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                }
                            }
                            
                            Spacer()
                            
                            Button(action: {
                                viewModel.cacheFeeling()
                                dismiss()
                            }, label: {
                                Image(systemName: "paperplane")
                                    .resizable()
                                    .frame(width: 24, height: 24)
                                
                            }).buttonStyle(.bordered)
                                .background(Color.accentColor)
                                .cornerRadius(8)
                                .foregroundColor(.white)
                        }.padding(.vertical, 16)
                            .frame(maxWidth: .infinity)
                        
                    }
                }
                .padding()
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading){
                        Image(systemName: "chevron.down")
                            .padding([.top, .bottom, .trailing])
                            .onTapGesture {
                                dismiss()
                            }
                    }
                }
            }.scrollDismissesKeyboard(.interactively)
        }
}

struct LogFeelingView_Previews: PreviewProvider {
    static var previews: some View {
        LogFeelingView()
    }
}
