//
//  HomeView.swift
//  QrGeneratorEx
//
//  Created by Batuhan Arda on 27.01.2025.
//

import SwiftUI
import SwiftData
import CoreImage.CIFilterBuiltins

struct HomeView: View {
    @Binding var selectionItem: Int
    @StateObject private var viewModel = QRCodeViewModel()
    @Environment(\.modelContext) private var context // SwiftData context

    @State private var url = ""
    @State private var title = ""
    @State private var qrCodeImage: UIImage?

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                // URL Girdisi
                TextField("Bağlantı girin (ör. https://www.google.com)", text: $url)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()

                // QR Kod Adı Girdisi
                TextField("QR Kod Adı", text: $title)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()

                // QR Kod Görüntüsü
                if let qrCodeImage = qrCodeImage {
                    Image(uiImage: qrCodeImage)
                        .resizable()
                        .interpolation(.none)
                        .scaledToFit()
                        .frame(width: 200, height: 200)
                        .padding()
                } else {
                    Text("Geçerli bir bağlantı girerek QR kod oluşturabilirsiniz.")
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)
                        .padding()
                }

                // QR Kod Oluşturma Butonu
                Button("QR Kod Oluştur") {
                    if let generatedImage = viewModel.generateQRCode(from: url) {
                        qrCodeImage = generatedImage
                    }
                }
                .buttonStyle(.borderedProminent)
                .padding()

                // QR Kod Kaydetme Butonu
                Button("QR Kod Kaydet") {
                    if let imageData = qrCodeImage?.pngData() {
                        viewModel.saveQRCode(title: title, url: url, imageData: imageData, context: context)
                        qrCodeImage = nil
                        url = ""
                        title = ""
                    }
                }
                .disabled(title.isEmpty || url.isEmpty || qrCodeImage == nil)
                .buttonStyle(.bordered)

                Spacer()
            }
            .navigationTitle("QR Kod Oluştur")
            .padding()
            .alert(item: $viewModel.errorMessage) { message in
                Alert(title: Text("Hata"), message: Text(message.value), dismissButton: .default(Text("Tamam")))
            }
        }
    }
}

#Preview {
    HomeView(selectionItem: .constant(0))
}
