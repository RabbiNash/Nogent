//
//  HomeView.swift
//  Nogent
//
//  Created by Tinashe Makuti on 04/02/2023.
//

import SwiftUI
import Charts

struct DashboardView: View {
    @StateObject private var viewModel: DashboardViewModel = .init()
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            LazyVStack(alignment: .leading, pinnedViews: [.sectionHeaders]) {
                dashboardHeaderView()
                
                if viewModel.feelings.isEmpty == false {
                    dashboardBodyView()
                    
                    trendsView()
                        .padding(.top, 32)
                } else {
                    HStack {
                        
                        Spacer()
                        
                        VStack {
                            
                            Spacer()
                            
                            Image("cool")
                                .resizable()
                                .frame(width: 132, height: 132)
                            
                            Text("No feelings logged yet, please click the plus icon above to add")
                                .padding(.top)
                                .multilineTextAlignment(.center)
                            
                            Button(action: {
                                withAnimation {
                                    viewModel.logFeeling.toggle()
                                }
                            }, label: {
                                Text("Log feeling")
                                    .padding(8)
                                    .padding(.horizontal, 16)
                            }).buttonStyle(.bordered)
                                .background(Color.accentColor)
                                .cornerRadius(32)
                                .foregroundColor(.white)
                        }
                        Spacer()
                    }.padding(.top, 32)
                }
            }.sheet(isPresented: $viewModel.logFeeling, onDismiss: {
                DispatchQueue.main.async {
                    viewModel.fetchCachedFeelings()
                }
            }) {
                LogFeelingView()
            }
        }
        .padding()
    }
    
    fileprivate func dashboardHeaderView() -> some View {
        return Section(content: {
            ScrollView(.horizontal, showsIndicators: false) {
                ScrollViewReader { (scrollView: ScrollViewProxy) in
                    HStack {
                        ForEach(viewModel.feelings, id: \.self) { feeling in
                            FeelingTabItemView(
                                currentFeeling: feeling,
                                isSelected: viewModel.selectedFeeling?.id == feeling.id
                            ).onTapGesture {
                                withAnimation {
                                    viewModel.selectedFeeling = feeling
                                    viewModel.scrollTarget = feeling
                                }
                            }
                        }
                    }.onAppear {
                        if let scrollTarget = viewModel.scrollTarget {
                            scrollView.scrollTo(scrollTarget, anchor: .trailing)
                        }
                        viewModel.fetchCachedFeelings()
                    } .onChange(of: viewModel.scrollTarget) { target in
                        if let target = target {
                            viewModel.scrollTarget = nil
                            
                            withAnimation {
                                scrollView.scrollTo(target, anchor: .trailing)
                            }
                        }
                    }
                }
            }
        }, header: {
            headerView()
        })
    }
    
    fileprivate func headerView() -> some View {
        return HStack {
            VStack(alignment: .leading, spacing: 8) {
                Text(Date().formatted(date: .abbreviated, time: .omitted))
                    .font(.system(size: 20))
                    .foregroundColor(.secondary)
                
                Text("How are you doing today?")
                    .font(.system(size: 20))
                    .fontWeight(.medium)
                    .foregroundColor(.primary)
                    .padding(.bottom)
            }
            
            Spacer()
            
            Image(systemName: "memories.badge.plus")
                .onTapGesture {
                    withAnimation {
                        viewModel.logFeeling.toggle()
                    }
                }
        }.background(.background)
    }
    
    fileprivate func dashboardBodyView() -> some View {
        return VStack(alignment: .leading, spacing: 8) {
            if let selectedFeeling = viewModel.selectedFeeling {
                Text("\(selectedFeeling.date.formatted(date: .abbreviated, time: .omitted)) you felt ")
                    .font(.headline)
                    .fontWeight(.light) + Text(selectedFeeling.feeling.rawValue).fontWeight(.bold).foregroundColor(.accentColor)
                
                
                Text("Given reason")
                    .font(.headline)
                    .padding(.top, 32)
                Divider()
                
                if let reason = selectedFeeling.reason {
                    if (reason.isEmpty) {
                        Text("None provided")
                            .padding(.top, 12)
                    } else {
                        Text(reason)
                            .padding(.top, 12)
                    }
                } else {
                    Text("You didn't tell me why 😔")
                        .padding(.top, 12)
                }
                
            }
        }.padding(.top, 8)
    }
    
    fileprivate func trendsView() -> some View {
        return VStack(alignment: .leading) {
            Text("Trends")
                .font(.headline)
            Divider()
            
            TabView {
                Chart {
                    ForEach(viewModel.aggregatedFeelings, id: \.self) { chartInfo in
                        BarMark(
                            x: .value("Feeling", chartInfo.label),
                            y: .value("Frequency", Int(chartInfo.value))
                        )
                    }
                }
                .chartXAxis {
                    AxisMarks {
                        AxisValueLabel()
                    }
                }.chartYAxis {
                    AxisMarks {
                        AxisValueLabel()
                    }
                }
            }
            .padding()
            .frame(height: 300)
            .tabViewStyle(PageTabViewStyle())
        }
    }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView()
    }
}
