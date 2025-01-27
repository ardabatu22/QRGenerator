//
//  QRCodeDetailView.swift
//  QrGeneratorEx
//
//  Created by Batuhan Arda on 27.01.2025.
//

import SwiftUI

struct QRCodeDetailView: View {
    @ObservedObject var viewModel: QRCodeViewModel
    let qrCode:QRCode

    var body: some View {
        VStack(spacing: 20) {
            // QR kod başlığı
            Text(qrCode.title)
                .font(.largeTitle)
                .bold()
                .multilineTextAlignment(.center)
                .padding()

            // URL bilgisi
            Text(qrCode.url)
                .font(.headline)
                .foregroundColor(.blue)
                .multilineTextAlignment(.center)
                .padding()

            // QR kod görüntüsü
            if let imageData = qrCode.imageData, let qrImage = UIImage(data: imageData) {
                Image(uiImage: qrImage)
                    .resizable()
                    .interpolation(.none)
                    .scaledToFit()
                    .frame(width: 200, height: 200)

                // QR Kodunu İndir Butonu
                Button("QR Kodunu İndir") {
                    viewModel.saveToPhotos(qrImage)
                }
                .buttonStyle(.borderedProminent)
                .padding()
            } else {
                Text("QR kodu görüntülenemedi.")
                    .foregroundColor(.red)
            }

            Spacer()
        }
        .padding()
        .navigationTitle("QR Kod Detayları")
        .navigationBarTitleDisplayMode(.inline)
        .alert(item: $viewModel.errorMessage) { message in
            Alert(title: Text("Hata"), message: Text(message.value), dismissButton: .default(Text("Tamam")))
        }
        .alert(item: $viewModel.successMessage) { message in
            Alert(title: Text("Başarılı"), message: Text(message.value), dismissButton: .default(Text("Tamam")))
        }
    }
}
