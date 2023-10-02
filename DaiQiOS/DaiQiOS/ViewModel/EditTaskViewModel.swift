import Foundation

class EditTaskViewModel: ObservableObject {
    @Published  var title = ""
    @Published  var description = ""
    @Published  var submitButtonDisabled = true
    
    func saveChanges(checklistItem: inout ChecklistItem) {
            checklistItem.title = title
            checklistItem.description = description
        }
}
