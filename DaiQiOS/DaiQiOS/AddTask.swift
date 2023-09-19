//
//  AddTask.swift
//  DaiQiOS
//
//  Created by Đinh Trần Việt Anh on 19/09/2023.
//

import SwiftUI

struct AddTask: View {
    @State private var title = ""
    @State private var description = ""
    @Environment(\.presentationMode) var presentationMode
    var onTaskSubmit: ((ChecklistItem) -> Void)?
    
    init(onTaskSubmit: @escaping (ChecklistItem) -> Void) {
        self.onTaskSubmit = onTaskSubmit
    }
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                HStack {
                    TextField("Title", text: $title)
                }
                Divider()
                HStack {
                    TextEditor(text: $description)
                        .frame(height: 100)
                        .cornerRadius(5)
                        .font(.body)
                }
                Spacer()
                Button(action: {
                    saveChanges()
                }) {
                    Text("Submit")
                        .font(.headline)
                        .foregroundColor(.blue)
                        .padding()
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(30)
                        .shadow(radius: 10)
                }
                .frame(maxWidth: .infinity)
            }
            .padding()
            .onAppear {
            }
        }
        .navigationTitle("Add Task")
    }

    private func saveChanges() {
//        checklistItem.title = title
//        checklistItem.description = description
        let checklistItem = ChecklistItem(title: title, description: description)
        onTaskSubmit?(checklistItem)
        presentationMode.wrappedValue.dismiss()
    }
}

