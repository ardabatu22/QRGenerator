# QR Generator 

QR Generator is a SwiftUI-based application that enables users to create, save, and view QR codes easily. This project is designed to provide a user-friendly experience for generating custom QR codes and managing them efficiently.

---

## Features

- **Generate QR Codes:** Create QR codes by entering a URL and a title.
- **Save QR Codes:** Save generated QR codes with their respective titles and URLs.
- **View Saved QR Codes:** View a list of saved QR codes and their details.
- **Share or Download:** Download QR codes to the device's photo library.

---

## Installation

### Requirements

- **Xcode 15** or later
- **iOS 16** or later

### Steps

1. Clone this repository:
   ```bash
   git clone https://github.com/yourusername/qr-generator-ex.git
   ```
2. Open the project in Xcode:
   ```bash
   open QrGeneratorEx.xcodeproj
   ```
3. Select a simulator or a connected device.
4. Build and run the project.

---

## Code Structure

- **QrGeneratorExApp.swift**: Entry point for the application.
- **RootView.swift**: Manages the main `TabView` for navigation between Home and Saved views.
- **HomeView.swift**: Provides the interface for creating and saving QR codes.
- **SavedView.swift**: Displays a list of saved QR codes.
- **QRCodeDetailView.swift**: Shows the details of a selected QR code.
- **QRCode.swift**: Data model for QR codes using SwiftData.
- **QRCodeViewModel.swift**: Contains the business logic for generating, saving, and managing QR codes.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

## Feedback

We welcome feedback and contributions! If you encounter any issues or have suggestions for improvement, feel free to open an issue or create a pull request.
