import Foundation

class ListViewModel: ObservableObject {
    @Published var checklistItems: [ChecklistItem] = [] {
        didSet {
            saveItems()
        }
    }
    let lastReset: String = "lastResetDate"
    let itemsKey : String = "items_list"
    init() {
        getItems()
        resetIfNewDay()
    }
    func getDay() {
        guard
            let data = UserDefaults.standard.data(forKey: lastReset),
            let savedDay = try? JSONDecoder().decode([ChecklistItem].self, from: data)
        else { return }
        self.checklistItems = savedDay
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
    func resetIfNewDay() {
        let currentDate = Date()
        if let lastResetDate = UserDefaults.standard.value(forKey: lastReset) as? Date {
            if !Calendar.current.isDate(lastResetDate, inSameDayAs: currentDate) {
                UserDefaults.standard.set(currentDate, forKey: lastReset)
                checklistItems.removeAll()
            }
        } else {
            UserDefaults.standard.set(currentDate, forKey: lastReset)
        }
    }
    }

