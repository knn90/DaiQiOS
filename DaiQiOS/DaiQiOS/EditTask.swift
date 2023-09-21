import SwiftUI

struct EditTask: View {
    @Binding var checklistItem: ChecklistItem
    @State private var title = ""
    @State private var description = ""
    
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
                .padding()
        }
        .tint(.purple.opacity(0.3))
        .controlSize(.small)
        .buttonStyle(.borderedProminent)
        .disabled(submitButtonDisabled)
    }
    
    @State private var submitButtonDisabled = true
    private func saveChanges() {
        checklistItem.title = title
        checklistItem.description = description
    }
}
