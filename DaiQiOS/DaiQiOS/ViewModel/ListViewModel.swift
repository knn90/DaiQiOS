import Foundation

class ListViewModel: ObservableObject {
    @Published var checklistItems: [ChecklistItem] = []
    init() {
        getItems()
    }
    
    func getItems() {
        let newItems =  [
            ChecklistItem(title: "Task 1", description: "Description 1"),
            ChecklistItem(title: "Task 2", description: "Description 2"),
            ChecklistItem(title: "Task 3", description: "Description 3"),
            ChecklistItem(title: "Task 4", description: "Description 4")
        ]
        checklistItems.append(contentsOf: newItems)
    }
    func delete(indexSet: IndexSet) {
        for index in indexSet {
            checklistItems.remove(at: index)
        }
    }
      func move(indices: IndexSet, newOffset: Int) {
        checklistItems.move(fromOffsets: indices, toOffset: newOffset)
    }
   
}
