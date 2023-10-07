import SwiftUI

struct EditTask: View {
    @EnvironmentObject var editTaskViewModel: EditTaskViewModel
    @Binding var checklistItem: ChecklistItem
    
    var body: some View {
        NavigationView {
            VStack(alignment: .center) {
                TitleArea()
                Spacer()
                    .frame(height: 30)
                DescriptionArea()
                Spacer()
                submitEditButton()
            }
            .padding()
            .onAppear {
                editTaskViewModel.title = checklistItem.title
                editTaskViewModel.description = checklistItem.description
            }
        }
        .navigationTitle("Edit Task")
    }
    
    func TitleArea() -> some View {
        VStack(alignment: .leading) {
            TextField("Title", text: $editTaskViewModel.title)
                .onChange(of: checklistItem.title) { newValue in
                    editTaskViewModel.submitButtonDisabled = newValue.isEmpty
                }
            Divider()
                .overlay(editTaskViewModel.title.isEmpty ? .red : .gray)
            if checklistItem.title.isEmpty {
                Text("Title could not be empty")
                    .foregroundColor(.red)
                    .font(.caption)
                    .multilineTextAlignment(.center)
                    .transition(AnyTransition.opacity.animation(.linear(duration: 0.5)))
            }
        }
    }
    
    func DescriptionArea () -> some View {
        VStack {
            TextField("Description",text: $editTaskViewModel.description, axis: .vertical)
                .lineLimit(1...5)
                .cornerRadius(5)
                .font(.body)
            Divider()
        }
    }
    @ViewBuilder
    private func submitEditButton() -> some View {
        Button(action: {
            editTaskViewModel.saveChanges(checklistItem: &checklistItem )
        }) {
            Text("Submit")
                .font(.headline)
                .padding()
        }
        .tint(.purple.opacity(0.3))
        .controlSize(.small)
        .buttonStyle(.borderedProminent)
        .disabled(editTaskViewModel.submitButtonDisabled)
    }
}

