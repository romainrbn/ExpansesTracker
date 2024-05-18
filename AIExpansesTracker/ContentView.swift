//
//  ContentView.swift
//  AIExpansesTracker
//
//  Created by Romain Rabouan on 09/05/2024.
//

import SwiftUI

struct ContentView: View {
    @State var viewModel = LogListViewModel()
    @Environment(\.horizontalSizeClass) var horizontalSizeClass

    @State private var selectedTabId: Int? = 0

    var body: some View {
        #if os(macOS)
        splitView
        #elseif os(visionOS)
        tabView
        #else
        switch horizontalSizeClass {
        case .compact: tabView
        default: splitView
        }
        #endif
    }

    private var tabView: some View {
        TabView(selection: $selectedTabId) {
            NavigationStack {
                LogListContainerView(viewModel: $viewModel)
            }
            .tabItem {
                Label("Dépenses", systemImage: "tray")
            }
            .tag(0)

            NavigationStack {
                AnalysisView()
            }
            .tabItem {
                Label("Analyse", systemImage: "chart.pie.fill")
            }
            .tag(1)
//
//            NavigationStack {
//                Text("Dashboard")
//            }
//            .tabItem {
//                Label("Dashboard", systemImage: "chart.pie.fill")
//            }
//            .tag(2)
        }
    }

    private var splitView: some View {
        NavigationSplitView {
            List(selection: $selectedTabId) {
                NavigationLink(destination: LogListContainerView(viewModel: $viewModel)) {
                    Label("Dépenses", systemImage: "tray")
                }
                .tag(0)

                NavigationLink(destination: AnalysisView()) {
                    Label("Analyse", systemImage: "chart.pie.fill")
                }
                .tag(1)
//
//                NavigationLink(destination: Text("Dashboard")) {
//                    Label("Dashboard", systemImage: "chart.pie.fill")
//                }
//                .tag(2)
            }
            .listStyle(.sidebar)
        } detail: {
            LogListContainerView(viewModel: $viewModel)
        }
        .navigationTitle("Suivi des dépenses")
    }
}

#Preview {
    ContentView()
}
