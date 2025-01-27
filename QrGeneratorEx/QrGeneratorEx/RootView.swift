//
//  ContentView.swift
//  QrGeneratorEx
//
//  Created by Batuhan Arda on 27.01.2025.
//

import SwiftUI

struct RootView: View {
    @State private var selectionItem = 0
    var body: some View {
        TabView(selection:$selectionItem){
            HomeView(selectionItem: $selectionItem)
                .tabItem { Label("Home",systemImage: "house")
                        .environment(\.symbolVariants,selectionItem == 0 ? .fill:.none)
                }.tag(0)
            SavedView(selectionItem: $selectionItem)
                .tabItem { Label("QR Generate",systemImage: "qrcode.viewfinder")
                        .environment(\.symbolVariants,selectionItem == 1 ? .fill: .none)
                }.tag(1)
        }.tint(.red)
    }
}

#Preview {
    RootView()
}
