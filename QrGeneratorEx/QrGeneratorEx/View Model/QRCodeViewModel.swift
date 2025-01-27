//
//  QRCodeViewModel.swift
//  QrGeneratorEx
//
//  Created by Batuhan Arda on 27.01.2025.
//

import SwiftUI
import SwiftData
import Photos

struct IdentifiableString: Identifiable {
    var id = UUID() // Benzersiz bir kimlik sağlar
    var value: String // Mesaj metni
    
    init(value: String) {
        self.value = value
    }
}


class QRCodeViewModel: ObservableObject {
    @Published var qrCodes: [QRCode] = []
    @Published var generatedQRCode: UIImage? = nil
    @Published var errorMessage: IdentifiableString? = nil
    @Published var successMessage: IdentifiableString? = nil
    
    
    func deleteQRCode(id: UUID, context: ModelContext) {
        if let qrCode = qrCodes.first(where: { $0.id == id }) {
            context.delete(qrCode) // SwiftData'dan sil
            do {
                try context.save() // Değişiklikleri kaydet
                qrCodes.removeAll { $0.id == id } // Yerel listeyi güncelle
            } catch {
                errorMessage = IdentifiableString(value: "Failed to delete QR Code from database.")
            }
        } else {
            errorMessage = IdentifiableString(value: "QR Code not found.")
        }
    }
    func loadQRCodes(context: ModelContext) {
        let request = FetchDescriptor<QRCode>() // Tüm QR kodlarını getir
        do {
            qrCodes = try context.fetch(request)
        } catch {
            errorMessage = IdentifiableString(value: "Failed to load QR Codes from database.")
        }
    }
    func generateQRCode(from string: String, size: CGSize = CGSize(width: 1024, height: 1024)) -> UIImage? {
            guard !string.isEmpty else {
                errorMessage = IdentifiableString(value: "Lütfen geçerli bir bağlantı girin.")
                return nil
            }

            let filter = CIFilter.qrCodeGenerator()
            filter.message = Data(string.utf8)

            if let outputImage = filter.outputImage {
                let scaleX = size.width / outputImage.extent.size.width
                let scaleY = size.height / outputImage.extent.size.height
                let transform = CGAffineTransform(scaleX: scaleX, y: scaleY)
                let scaledImage = outputImage.transformed(by: transform)

                let context = CIContext()
                if let cgImage = context.createCGImage(scaledImage, from: scaledImage.extent) {
                    return UIImage(cgImage: cgImage)
                }
            }

            errorMessage = IdentifiableString(value: "QR kodu oluşturulamadı.")
            return nil
        }

        /// QR kodunu kaydeder
        func saveQRCode(title: String, url: String, imageData: Data, context: ModelContext) {
            guard !title.isEmpty, !url.isEmpty else {
                errorMessage = IdentifiableString(value: "Başlık ve bağlantı boş olamaz.")
                return
            }

            let qrCode = QRCode(title: title, url: url, imageData: imageData)
            context.insert(qrCode)

            do {
                try context.save()
            } catch {
                errorMessage = IdentifiableString(value: "QR kodu kaydedilirken bir hata oluştu.")
            }
        }
    func saveToPhotos(_ image: UIImage) {
            // Fotoğraf izni kontrolü
            PHPhotoLibrary.requestAuthorization { status in
                DispatchQueue.main.async {
                    if status == .authorized {
                        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
                        self.successMessage = IdentifiableString(value: "QR kodu başarıyla kaydedildi!")
                    } else {
                        self.errorMessage = IdentifiableString(value: "Fotoğraflara erişim izni verilmedi.")
                    }
                }
            }
        }
}
