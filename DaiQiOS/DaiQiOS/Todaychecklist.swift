import SwiftUI

struct TodayChecklist: View {
    @State var checklistItems: [ChecklistItem] = [
        ChecklistItem(title: "Task 1", description: "Description 1"),
        ChecklistItem(title: "Task 2", description: "Description 2"),
        ChecklistItem(title: "Task 3", description: "Description 3")
    ]

    var body: some View {
        NavigationView {
            List {
                Section {
                    ForEach(checklistItems.indices, id: \.self) { index in
                        NavigationLink(destination: EditTask(checklistItem: $checklistItems[index])) {
                            TaskCell(checklistItem: checklistItems[index])
                        }
                    }
                    .onDelete(perform: { indexSet in
                        delete(indexSet: indexSet)
                    })
                }
                Section {
                    addTaskButton()
                }
            }
          
            .listStyle(InsetGroupedListStyle())
            .navigationTitle("Today Checklist")
        }
    }
    
    @ViewBuilder
    private func addTaskButton() -> some View {
        HStack {
            Spacer()
            Button(action: {
                let newItem = ChecklistItem(title: "New Task", description: "New Description")
                checklistItems.append(newItem)
            }) {
                Image(systemName: "plus")
                    .font(.system(size: 24))
                    .frame(width: 64, height: 64)
                    .background(Color.purple.opacity(0.3))
                    .foregroundColor(.white)
                    .clipShape(Circle())
            }
            Spacer()
        }
    }
    
    func delete(indexSet: IndexSet) {
        checklistItems.remove(atOffsets: indexSet)
    }

    struct TodayChecklist_Previews: PreviewProvider {
        static var previews: some View {
            TodayChecklist()
        }
    }
}
