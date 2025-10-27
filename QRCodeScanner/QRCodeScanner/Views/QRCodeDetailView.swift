//
//  QRCodeDetailView.swift
//  QRCodeScanner
//
//  Detailed view of a scanned QR code
//

import SwiftUI
import CoreData

struct QRCodeDetailView: View {
    @ObservedObject var qrCode: QRCode
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) private var dismiss
    
    @State private var editedNote: String
    @State private var showingCopiedAlert = false
    
    init(qrCode: QRCode) {
        self.qrCode = qrCode
        _editedNote = State(initialValue: qrCode.note ?? "")
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("内容")) {
                    Text(qrCode.content ?? "")
                        .textSelection(.enabled)
                    
                    Button(action: {
                        UIPasteboard.general.string = qrCode.content
                        showingCopiedAlert = true
                    }) {
                        HStack {
                            Image(systemName: "doc.on.doc")
                            Text("内容をコピー")
                        }
                    }
                }
                
                Section(header: Text("スキャン日時")) {
                    if let date = qrCode.scannedDate {
                        HStack {
                            Text("日付")
                            Spacer()
                            Text(date, style: .date)
                                .foregroundColor(.secondary)
                        }
                        
                        HStack {
                            Text("時刻")
                            Spacer()
                            Text(date, style: .time)
                                .foregroundColor(.secondary)
                        }
                    }
                }
                
                Section(header: Text("メモ")) {
                    TextEditor(text: $editedNote)
                        .frame(minHeight: 100)
                }
                
                // URL detection
                if let content = qrCode.content, let url = URL(string: content), UIApplication.shared.canOpenURL(url) {
                    Section(header: Text("アクション")) {
                        Button(action: {
                            UIApplication.shared.open(url)
                        }) {
                            HStack {
                                Image(systemName: "safari")
                                Text("URLを開く")
                            }
                        }
                    }
                }
            }
            .navigationTitle("詳細")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("キャンセル") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("保存") {
                        saveNote()
                    }
                }
            }
            .alert("コピーしました", isPresented: $showingCopiedAlert) {
                Button("OK", role: .cancel) { }
            }
        }
    }
    
    private func saveNote() {
        qrCode.note = editedNote.isEmpty ? nil : editedNote
        
        do {
            try viewContext.save()
            dismiss()
        } catch {
            let nsError = error as NSError
            print("Error saving note: \(nsError), \(nsError.userInfo)")
        }
    }
}
