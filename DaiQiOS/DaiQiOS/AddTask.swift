
import SwiftUI

struct AddTask: View {
    @State private var title = ""
    @State private var description = ""
    @Environment(\.presentationMode) var presentationMode
    @State private var showAlert = false
    var onTaskSubmit: ((ChecklistItem) -> Void)?
    
    init(onTaskSubmit: @escaping (ChecklistItem) -> Void) {
        self.onTaskSubmit = onTaskSubmit
    }
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                TextField("Title", text: $title)
                Divider()
                TextEditor(text: $description)
                    .frame(height: 100)
                    .cornerRadius(5)
                    .font(.body)
                Spacer()
                submitAddTaskButton()
            }
            .padding()
        }
        .navigationTitle("Add Task")
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text("Empty Fields"),
                message: Text("Both Title and Description cannot be empty.")
            )
        }
    }
    
    @ViewBuilder
    private func submitAddTaskButton() -> some View {
        Button(action: {
            if title.isEmpty || description.isEmpty {
                showAlert = true
            } else {
                saveChanges()
            }}) {
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
    private func saveChanges() {
        let checklistItem = ChecklistItem(title: title, description: description)
        onTaskSubmit?(checklistItem)
        presentationMode.wrappedValue.dismiss()
    }
}

