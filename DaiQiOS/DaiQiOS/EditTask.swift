import SwiftUI

struct EditTask: View {
    @Binding var checklistItem: ChecklistItem
    @State private var title = ""
    @State private var description = ""
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
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
                }
     
                Divider()
                TextEditor(text: $description)
                    .frame(height: 100)
                    .cornerRadius(5)
                    .font(.body)
                    
                Divider()
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
        checklistItem.title = title
        checklistItem.description = description
    }
}
