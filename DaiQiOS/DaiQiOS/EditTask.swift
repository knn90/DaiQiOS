import SwiftUI

struct EditTask: View {
    @Binding var checklistItem: ChecklistItem
    @State private var title = ""
    @State private var description = ""
    @State private var showAlert = false
    
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
                submitEditButton()
            }
            .padding()
            .onAppear {
                title = checklistItem.title
                description = checklistItem.description
            }
        }
        .navigationTitle("Edit Task")
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text("Empty Fields"),
                message: Text("Both Title and Description cannot be empty."),
                dismissButton: .default(Text("OK")) {
                }
            )
        }
    }
    
    @ViewBuilder
    private func submitEditButton() -> some View {
        Button(action: {
            if title.isEmpty || description.isEmpty {
                showAlert = true
            } else {
                saveChanges()
            }
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
    
    private func saveChanges() {
        checklistItem.title = title
        checklistItem.description = description
    }
}
