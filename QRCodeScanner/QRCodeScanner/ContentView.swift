//
//  ContentView.swift
//  QRCodeScanner
//
//  Main content view with tab navigation
//

import SwiftUI

struct ContentView: View {
    @State private var selectedTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            NavigationView {
                HistoryView()
            }
            .tabItem {
                Label("履歴", systemImage: "clock")
            }
            .tag(0)
            
            NavigationView {
                ScannerView()
            }
            .tabItem {
                Label("スキャン", systemImage: "camera")
            }
            .tag(1)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
    }
}
