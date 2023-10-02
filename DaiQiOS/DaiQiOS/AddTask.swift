
import SwiftUI

struct AddTask: View {
    @EnvironmentObject var addTaskViewModel: AddTaskViewModel
    @EnvironmentObject var listViewModel: ListViewModel
    @Environment(\.presentationMode) var presentationMode
    var onTaskSubmit: ((ChecklistItem) -> Void)?
    
    init(onTaskSubmit: @escaping (ChecklistItem) -> Void) {
        self.onTaskSubmit = onTaskSubmit
    }
    
    var body: some View {
        NavigationView {
            VStack(alignment: .center) {
                TitleArea()
                Spacer()
                    .frame(height: 30)
                DescriptionArea()
                Spacer()
                submitAddTaskButton()
                    .padding()
                    .toolbar {
                        ToolbarItem(placement: .principal) {
                            Text("Add Task")
                                .font(.title)
                                .bold()
                                .foregroundColor(.primary)
                        }
                        ToolbarItem(placement: .navigationBarLeading) {
                            Button("Cancel") {
                                presentationMode.wrappedValue.dismiss()
                            }
                        }
                    }
            }
        }
    }
    func TitleArea() -> some View {
        VStack(alignment: .leading) {
            TextField("Title", text: $addTaskViewModel.title)
                .onChange(of: addTaskViewModel.title) { newValue in
                    addTaskViewModel.submitButtonDisabled = newValue.isEmpty
                }
            Divider()
                .overlay(addTaskViewModel.title.isEmpty ? .red : .gray)
            if addTaskViewModel.title.isEmpty {
                Text("Title could not be empty")
                    .foregroundColor(.red)
                    .font(.caption)
                    .multilineTextAlignment(.center)
                    .transition(AnyTransition.opacity.animation(.linear(duration: 0.5)))
            }
        }
        .padding()
    }
    
    func DescriptionArea() -> some View {
        VStack {
            TextField("Description",text: $addTaskViewModel.description, axis: .vertical)
                .lineLimit(1...5)
                .cornerRadius(5)
                .font(.body)
            Divider()
        }
        .padding()
    }
    
    @ViewBuilder
    private func submitAddTaskButton() -> some View {
        Button(action: {
            let checklist = ChecklistItem(title: "", description: "")
            onTaskSubmit?(checklist)
        }
            ) {
                Text("Submit")
                    .font(.headline)
                    .padding()
            }
            .tint(.purple.opacity(0.3))
            .controlSize(.small)
            .buttonStyle(.borderedProminent)
            .disabled(addTaskViewModel.submitButtonDisabled)
        }
               }
               
