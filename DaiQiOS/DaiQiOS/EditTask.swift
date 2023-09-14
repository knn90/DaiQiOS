import SwiftUI

struct EditTask: View {
    @Binding var checklistItem: ChecklistItem
    @State private var text = ""


    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                HStack {
                    TextField("Title", text: $checklistItem.title)
                }
                Divider()
                HStack {
                    TextEditor(text: $checklistItem.description)
                        .frame(height: 100)
                        .cornerRadius(5)
                        .font(.body)
                }
                Spacer()
                Button(action: {}) {
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
        }
        .navigationTitle("Edit Task")
    }
}


