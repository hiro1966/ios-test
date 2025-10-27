//
//  CameraPreview.swift
//  QRCodeScanner
//
//  Camera preview layer for QR code scanning
//

import SwiftUI
import AVFoundation

struct CameraPreview: UIViewRepresentable {
    let session: AVCaptureSession?
    
    func makeUIView(context: Context) -> UIView {
        let view = UIView(frame: .zero)
        view.backgroundColor = .black
        
        guard let session = session else { return view }
        
        let previewLayer = AVCaptureVideoPreviewLayer(session: session)
        previewLayer.videoGravity = .resizeAspectFill
        previewLayer.frame = view.bounds
        view.layer.addSublayer(previewLayer)
        
        // Store the layer in the view for later updates
        view.layer.name = "previewLayer"
        
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        // Update the preview layer frame when view size changes
        if let sublayers = uiView.layer.sublayers {
            for layer in sublayers {
                if let previewLayer = layer as? AVCaptureVideoPreviewLayer {
                    DispatchQueue.main.async {
                        previewLayer.frame = uiView.bounds
                    }
                }
            }
        }
    }
}
