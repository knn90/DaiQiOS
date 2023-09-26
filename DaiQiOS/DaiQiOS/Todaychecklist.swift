import SwiftUI

struct TodayChecklist: View {
    @State var checklistItems: [ChecklistItem] = [
        ChecklistItem(title: "Task 1", description: "Description 1"),
        ChecklistItem(title: "Task 2", description: "Description 2"),
        ChecklistItem(title: "Task 3", description: "Description 3")
    ]
    @State private var showingSheet = false
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
                    .onMove(perform: { indices, newOffset in
                        move(indices: indices, newOffset: newOffset)
                        
                    })}
                .navigationBarItems(trailing: EditButton())
                .accentColor(.purple)
                .listStyle(InsetGroupedListStyle())
                .navigationTitle("Today Checklist")
                Spacer()
                addTaskButton()
            }
        }   .sheet(isPresented: $showingSheet, content: {
            AddTask { checklistItem in
                checklistItems.append(checklistItem)
                showingSheet.toggle()
            }
        })
    }
    @ViewBuilder
    private func addTaskButton() -> some View {
        HStack {
            Button(action: {
                showingSheet.toggle()
                
            }) {
                Image(systemName: "plus")
                    .font(.system(size: 24))
                    .frame(minWidth: 64, minHeight: 64)
                    .background(Color.purple.opacity(0.3))
                    .foregroundColor(.white)
                    .clipShape(Circle())
                    .padding()
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
    private  func move(indices: IndexSet, newOffset: Int) {
        checklistItems.move(fromOffsets: indices, toOffset: newOffset)
    }
    struct TodayChecklist_Previews: PreviewProvider {
        static var previews: some View {
            TodayChecklist()
        }
    }
}
