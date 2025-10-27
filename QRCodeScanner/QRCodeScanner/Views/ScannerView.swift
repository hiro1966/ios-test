//
//  ScannerView.swift
//  QRCodeScanner
//
//  QR Code scanner screen
//

import SwiftUI
import CoreData

struct ScannerView: View {
    @StateObject private var scannerService = QRCodeScannerService()
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) private var dismiss
    
    @State private var showingSaveAlert = false
    @State private var scannedResult = ""
    @State private var noteText = ""
    
    var body: some View {
        ZStack {
            // Camera preview
            CameraPreview(session: scannerService.captureSession)
                .ignoresSafeArea()
            
            // Scanning frame overlay
            VStack {
                Spacer()
                
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color.green, lineWidth: 3)
                    .frame(width: 280, height: 280)
                    .overlay(
                        VStack {
                            Image(systemName: "qrcode.viewfinder")
                                .font(.system(size: 80))
                                .foregroundColor(.green.opacity(0.8))
                            
                            Text("QRコードをスキャン")
                                .font(.headline)
                                .foregroundColor(.white)
                                .padding(.top, 20)
                                .shadow(radius: 2)
                        }
                    )
                
                Spacer()
                
                // Instructions
                Text("QRコードをフレーム内に配置してください")
                    .font(.subheadline)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.black.opacity(0.7))
                    .cornerRadius(10)
                    .padding(.bottom, 40)
            }
        }
        .navigationTitle("QRコードスキャン")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            scannerService.startScanning()
        }
        .onDisappear {
            scannerService.stopScanning()
        }
        .onChange(of: scannerService.scannedCode) { newValue in
            if let code = newValue {
                scannedResult = code
                showingSaveAlert = true
            }
        }
        .alert("QRコードを読み取りました", isPresented: $showingSaveAlert) {
            Button("保存") {
                saveQRCode()
                dismiss()
            }
            Button("再スキャン") {
                scannerService.scannedCode = nil
                scannerService.startScanning()
            }
            Button("キャンセル") {
                dismiss()
            }
        } message: {
            VStack {
                Text("内容: \(scannedResult)")
                TextField("メモ（任意）", text: $noteText)
            }
        }
    }
    
    private func saveQRCode() {
        let newQRCode = QRCode(context: viewContext)
        newQRCode.id = UUID()
        newQRCode.content = scannedResult
        newQRCode.scannedDate = Date()
        newQRCode.note = noteText.isEmpty ? nil : noteText
        
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            print("Error saving QR code: \(nsError), \(nsError.userInfo)")
        }
    }
}

struct ScannerView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ScannerView()
        }
    }
}
