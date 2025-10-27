//
//  QRCodeScannerApp.swift
//  QRCodeScanner
//
//  Main application entry point
//

import SwiftUI

@main
struct QRCodeScannerApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
