import SwiftUI

struct EditTask: View {
    @Binding var checklistItem: ChecklistItem
    @State private var title = ""
    @State private var description = ""
    @State private var isTitleEmpty = false
    
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
                submitEditButton()
           }
            .padding()
            .onAppear {
                title = checklistItem.title
                description = checklistItem.description
            }
        }
        .navigationTitle("Edit Task")
    }
    
    @ViewBuilder
    private func submitEditButton() -> some View {
        Button(action: {
            if title.isEmpty {
                isTitleEmpty = true
            } else {
                isTitleEmpty = false
                saveChanges()
            }
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
    }
    
    private func saveChanges() {
        checklistItem.title = title
        checklistItem.description = description
    }
}
