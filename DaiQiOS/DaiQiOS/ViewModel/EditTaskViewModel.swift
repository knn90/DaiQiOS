//
//  EditTaskViewModel.swift
//  DaiQiOS
//
//  Created by Đinh Trần Việt Anh on 27/09/2023.
//

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
