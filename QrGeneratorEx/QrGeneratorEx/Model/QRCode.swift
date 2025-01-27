//
//  QRCode.swift
//  QrGeneratorEx
//
//  Created by Batuhan Arda on 27.01.2025.
//

import Foundation
import SwiftData

@Model
class QRCode: Identifiable {
    var id: UUID
    var title: String
    var url: String
    var imageData: Data? // QR kod görüntüsünü saklamak için

    init(title: String, url: String, imageData: Data? = nil) {
        self.id = UUID()
        self.title = title
        self.url = url
        self.imageData = imageData
    }
}
