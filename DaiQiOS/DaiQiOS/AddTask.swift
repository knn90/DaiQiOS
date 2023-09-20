
import SwiftUI

struct AddTask: View {
    @State private var title = ""
    @State private var description = ""
    @Environment(\.presentationMode) var presentationMode
    var onTaskSubmit: ((ChecklistItem) -> Void)?
    @State private var isTitleEmpty = false
    
    init(onTaskSubmit: @escaping (ChecklistItem) -> Void) {
        self.onTaskSubmit = onTaskSubmit
    }
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                TextField("Title", text: $title)
                if isTitleEmpty {
                    Text("Title could not be empty")
                        .foregroundColor(.red)
                        .font(.caption)
                }
                Divider()
                TextEditor(text: $description)
                    .frame(height: 100)
                    .cornerRadius(5)
                    .font(.body)
                    .border(Color.black.opacity(0.1), width: 5)
                Spacer()
                submitAddTaskButton()
            }
            .padding()
        }
        .navigationTitle("Add Task")
    }
    
    @ViewBuilder
    private func submitAddTaskButton() -> some View {
        Button(action: {
            if title.isEmpty {
                isTitleEmpty = true
            } else {
                isTitleEmpty = false
                saveChanges()
            } }) {
                Text("Submit")
                    .font(.headline)
                    .foregroundColor(.purple)
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(30)
                    .shadow(radius: 10)
            }
            .frame(maxWidth: .infinity)
    }
    private func saveChanges() {
        let checklistItem = ChecklistItem(title: title, description: description)
        onTaskSubmit?(checklistItem)
        presentationMode.wrappedValue.dismiss()
    }
}

