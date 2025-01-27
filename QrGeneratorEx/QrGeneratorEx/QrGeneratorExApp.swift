//
//  QrGeneratorExApp.swift
//  QrGeneratorEx
//
//  Created by Batuhan Arda on 27.01.2025.
//

import SwiftUI
import SwiftData

@main
struct QrGeneratorExApp: App {
    var body: some Scene {
        WindowGroup {
            RootView()
        }
         .modelContainer(for: QRCode.self) // SwiftData için model container ekleyin

    }
}
