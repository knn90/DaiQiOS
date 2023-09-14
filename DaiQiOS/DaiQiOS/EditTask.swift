import SwiftUI
struct EditTask: View {
    @Binding var checklistItem: ChecklistItem
    @State private var title = ""
    @State private var description = ""

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
                title = checklistItem.title
                description = checklistItem.description
            }
        }
        .navigationTitle("Edit Task")
    }

    private func saveChanges() {
        checklistItem.title = title
        checklistItem.description = description
    }
}
