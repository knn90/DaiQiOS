import SwiftUI

struct TodayChecklist: View {
    
    @State var checklistItems: [ChecklistItem] = [
        ChecklistItem(title: "Task 1", description: "Description 1"),
        ChecklistItem(title: "Task 2", description: "Description 2"),
        ChecklistItem(title: "Task 3", description: "Description 3")
    ]
    
    var body: some View {
        NavigationView {
            ZStack {
                List {
                    Section{   ForEach(checklistItems, id: \.self) { item in
                        NavigationLink(destination: EditTask()) {
                            TaskCell(checklistItem: item)
                        }
                    }                    .onDelete(perform: { indexSet in
                        delete(indexSet: indexSet)
                    })

                    }
                 }
                .navigationTitle("Today Checklist")
                addTaskButton()
            }
        }
    }
    func delete(indexSet: IndexSet) {
        checklistItems.remove(atOffsets: indexSet)
    }
    @ViewBuilder
    private func addTaskButton() -> some View {
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
    }
    
    struct TodayChecklist_Previews: PreviewProvider {
        static var previews: some View {
            TodayChecklist()
        }
    }
}
