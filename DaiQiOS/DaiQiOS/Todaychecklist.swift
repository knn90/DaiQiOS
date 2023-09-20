import SwiftUI

struct TodayChecklist: View {
    @State var checklistItems: [ChecklistItem] = [
        ChecklistItem(title: "Task 1", description: "Description 1"),
        ChecklistItem(title: "Task 2", description: "Description 2"),
        ChecklistItem(title: "Task 3", description: "Description 3")
    ]
    @State private var isAddTaskViewPresented = false
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(Array(checklistItems.enumerated()), id: \.element.id) { (index, item) in
                        NavigationLink(destination: EditTask(checklistItem: $checklistItems[index])) {
                            TaskCell(checklistItem: item)
                        }
                    }
                    .onDelete(perform: { indexSet in
                        delete(indexSet: indexSet)
                    })
             
}
                .listStyle(InsetGroupedListStyle())
                .navigationTitle("Today Checklist")
                Spacer()
                addTaskButton()
            }
        }
    }
    @ViewBuilder
    private func addTaskButton() -> some View {
        HStack {
            NavigationLink(destination: AddTask(onTaskSubmit: { checklistItem in
                checklistItems.append(checklistItem)
            }), isActive: $isAddTaskViewPresented) {
                EmptyView()
            }
                Button(action: {
                    isAddTaskViewPresented = true
                }) {
                    Image(systemName: "plus")
                        .font(.system(size: 24))
                        .frame(minWidth: 64, maxWidth: .infinity, minHeight: 64)
                        .background(Color.purple.opacity(0.3))
                        .foregroundColor(.white)
                        .clipShape(Circle())
                }
            
        }
    }
    
    private func getIndex(for item: ChecklistItem) -> Int {
        if let index = checklistItems.firstIndex(where: { $0.id == item.id }) {
            return index
        }
        return 0
    }
    
    func delete(indexSet: IndexSet) {
        for index in indexSet {
            checklistItems.remove(at: index)
        }
    }
    
    struct TodayChecklist_Previews: PreviewProvider {
        static var previews: some View {
            TodayChecklist()
        }
    }
}
