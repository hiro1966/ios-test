//
//  HistoryView.swift
//  QRCodeScanner
//
//  History of scanned QR codes
//

import SwiftUI
import CoreData

struct HistoryView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \QRCode.scannedDate, ascending: false)],
        animation: .default)
    private var qrCodes: FetchedResults<QRCode>
    
    @State private var selectedQRCode: QRCode?
    @State private var showingDetail = false
    
    var body: some View {
        List {
            ForEach(qrCodes) { qrCode in
                QRCodeRow(qrCode: qrCode)
                    .contentShape(Rectangle())
                    .onTapGesture {
                        selectedQRCode = qrCode
                        showingDetail = true
                    }
            }
            .onDelete(perform: deleteQRCodes)
        }
        .navigationTitle("スキャン履歴")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                EditButton()
            }
        }
        .sheet(isPresented: $showingDetail) {
            if let qrCode = selectedQRCode {
                QRCodeDetailView(qrCode: qrCode)
            }
        }
        .overlay {
            if qrCodes.isEmpty {
                VStack(spacing: 20) {
                    Image(systemName: "qrcode")
                        .font(.system(size: 80))
                        .foregroundColor(.gray)
                    
                    Text("スキャン履歴がありません")
                        .font(.headline)
                        .foregroundColor(.secondary)
                    
                    Text("カメラアイコンをタップしてQRコードをスキャンしてください")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                }
            }
        }
    }
    
    private func deleteQRCodes(offsets: IndexSet) {
        withAnimation {
            offsets.map { qrCodes[$0] }.forEach(viewContext.delete)
            
            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                print("Error deleting QR code: \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

struct QRCodeRow: View {
    let qrCode: QRCode
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(qrCode.content ?? "Unknown")
                .font(.body)
                .lineLimit(2)
            
            HStack {
                Text(qrCode.scannedDate ?? Date(), style: .date)
                    .font(.caption)
                    .foregroundColor(.secondary)
                
                Text(qrCode.scannedDate ?? Date(), style: .time)
                    .font(.caption)
                    .foregroundColor(.secondary)
                
                Spacer()
                
                if let note = qrCode.note, !note.isEmpty {
                    Image(systemName: "note.text")
                        .font(.caption)
                        .foregroundColor(.blue)
                }
            }
        }
        .padding(.vertical, 4)
    }
}

struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            HistoryView()
                .environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
        }
    }
}
