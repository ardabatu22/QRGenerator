//
//  SavedView.swift
//  QrGeneratorEx
//
//  Created by Batuhan Arda on 27.01.2025.
//

import SwiftUI
import SwiftData

struct SavedView: View {
    @Binding var selectionItem: Int
    @StateObject var viewModel = QRCodeViewModel()
    @Environment(\.modelContext) private var context // SwiftData context

    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.qrCodes) { qrCode in
                    NavigationLink(destination: QRCodeDetailView(viewModel:viewModel,qrCode: qrCode)) {
                        VStack(alignment: .leading) {
                            Text(qrCode.title)
                                .font(.headline)
                            Text(qrCode.url)
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                    }
                }
                .onDelete { indexSet in
                    indexSet.map { viewModel.qrCodes[$0] }.forEach { qrCode in
                        if let context = qrCode.modelContext {
                            viewModel.deleteQRCode(id: qrCode.id, context: context)
                        }
                    }
                }

            }
            .navigationTitle("Kaydedilen QR Kodlar")
            .onAppear {
                viewModel.loadQRCodes(context: context)
            }
            .alert(item: $viewModel.errorMessage) { message in
                Alert(title: Text("Hata"), message: Text(message.value), dismissButton: .default(Text("Tamam")))
            }
        }
    }
}

#Preview {
    // We have to create this structers to look preview
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: QRCode.self, configurations: config)

        let context = container.mainContext
        let sampleQRCode = QRCode(title: "Örnek QR Kod", url: "https://www.example.com")
        context.insert(sampleQRCode)

        return SavedView(selectionItem: .constant(1))
            .modelContainer(container)
    } catch {
        fatalError("Failed to create model container: \(error.localizedDescription)")
    }
}
