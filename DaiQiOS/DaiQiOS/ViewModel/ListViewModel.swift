import Foundation

class ListViewModel: ObservableObject {
    @Published var checklistItems: [ChecklistItem] = [] {
        didSet {
            saveItems()
        }
    }
    
    let itemsKey : String = "items_list"
    init() {
        getItems()
    }
    
    func getItems() { 
        guard
            let data = UserDefaults.standard.data(forKey: itemsKey),
            let savedItems = try? JSONDecoder().decode([ChecklistItem].self, from: data)
        else { return }
        self.checklistItems = savedItems
    }
    func delete(indexSet: IndexSet) {
        for index in indexSet {
            checklistItems.remove(at: index)
        }
    }
      func move(indices: IndexSet, newOffset: Int) {
        checklistItems.move(fromOffsets: indices, toOffset: newOffset)
    }
    func saveItems() {
        if let encodedData = try? JSONEncoder().encode(checklistItems) {
            UserDefaults.standard.set(encodedData, forKey: itemsKey)
        }
    }
}
