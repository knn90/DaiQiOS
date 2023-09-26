import SwiftUI

struct EditTask: View {
    @Binding var checklistItem: ChecklistItem
    @State private var title = ""
    @State private var description = ""
    @State private var submitButtonDisabled = true
    
    var body: some View {
        NavigationView {
            VStack(alignment: .center) {
                edittingTitle()
                Spacer()
                    .frame(height: 30)
                edittingDescription()
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
    
    func edittingTitle() -> some View {
        VStack(alignment: .leading) {
            TextField("Title", text: $title)
                .onChange(of: title) { newValue in
                    submitButtonDisabled = newValue.isEmpty
                }
            Divider()
                .overlay(title.isEmpty ? .red : .gray)
            if title.isEmpty {
                Text("Title could not be empty")
                    .foregroundColor(.red)
                    .font(.caption)
                    .multilineTextAlignment(.center)
                    .transition(AnyTransition.opacity.animation(.linear(duration: 0.5)))
            }
        }
    }
    
    func edittingDescription () -> some View {
        VStack {
            TextField("Description",text: $description, axis: .vertical)
                .lineLimit(1...5)
                .cornerRadius(5)
                .font(.body)
            Divider()
        }
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
    private func saveChanges() {
        checklistItem.title = title
        checklistItem.description = description
    }
}
