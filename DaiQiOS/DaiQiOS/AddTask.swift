
import SwiftUI

struct AddTask: View {
    @State private var title = ""
    @State private var description = ""
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.dismiss) var dismiss
    var onTaskSubmit: ((ChecklistItem) -> Void)?
    
    init(onTaskSubmit: @escaping (ChecklistItem) -> Void) {
        self.onTaskSubmit = onTaskSubmit
    }
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                Button("cancel") {
                    dismiss()
                }
                .foregroundStyle(.purple.opacity(0.5))
                .font(.title)
                .background(.white)
                
                TextField("Title", text: $title)
                    .onChange(of: title) { newValue in
                        if newValue.isEmpty {
                            submitButtonDisabled = true
                        } else {
                            submitButtonDisabled = false
                        }
                    }
                Divider().frame(maxHeight: 2)
                    .overlay(.red)
                if title.isEmpty {
                    Text("Title could not be empty")
                        .foregroundColor(.red)
                        .font(.caption)
                        .multilineTextAlignment(.center)
                }
                Divider()
                Text("Description:")
                    .font(.caption)
                TextEditor(text: $description)
                    .frame(height: 100)
                    .cornerRadius(5)
                    .font(.body)
                
                Divider()
                Spacer()
                submitAddTaskButton()
            }
            .padding()
        }.navigationTitle("Add Task")
    }
    
    @ViewBuilder
    private func submitAddTaskButton() -> some View {
        Button(action: {
            saveChanges()
        }) {
            Text("Submit")
                .font(.headline)
                .foregroundColor(.purple)
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(30)
                .shadow(radius: 10)
        }
        .frame(maxWidth: .infinity)
        .disabled(submitButtonDisabled)
    }
    @State private var submitButtonDisabled = true
    private func saveChanges() {
        let checklistItem = ChecklistItem(title: title, description: description)
        onTaskSubmit?(checklistItem)
        presentationMode.wrappedValue.dismiss()
    }
}

