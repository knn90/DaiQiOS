
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
            VStack(alignment: .center) {
                VStack(alignment: .leading) {
                    TextField("Title", text: $title)
                        .onChange(of: title) { newValue in
                            if newValue.isEmpty {
                                submitButtonDisabled = true
                            } else {
                                submitButtonDisabled = false
                            }
                        }
                    Divider()
                        .overlay(title.isEmpty ? .red : .gray)
                    if title.isEmpty {
                        Text("Title could not be empty")
                            .foregroundColor(.red)
                            .font(.caption)
                            .multilineTextAlignment(.center)
                    }
                }
                TextField("Description",text: $description, axis: .vertical)
                    .lineLimit(1...5)
                    .cornerRadius(5)
                    .font(.body)
                
                Divider()
                Spacer()
                submitAddTaskButton()
            }
            .padding()
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Add Task")
                        .font(.title)
                        .bold()
                        .foregroundColor(.primary)
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        presentationMode.wrappedValue.dismiss()
                    }
                }
            }
        }
    }
    @ViewBuilder
    private func submitAddTaskButton() -> some View {
        Button(action: {
            saveChanges()
        }) {
            Text("Submit")
                .font(.headline)
                .padding()
        }
        .tint(.purple.opacity(0.3))
        .controlSize(.small) 
        .buttonStyle(.borderedProminent)
        .disabled(submitButtonDisabled)
    }
    @State private var submitButtonDisabled = true
    private func saveChanges() {
        let checklistItem = ChecklistItem(title: title, description: description)
        onTaskSubmit?(checklistItem)
        presentationMode.wrappedValue.dismiss()
    }
}

