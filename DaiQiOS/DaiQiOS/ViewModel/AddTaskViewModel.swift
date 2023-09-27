//
//  AddTaskViewModel.swift
//  DaiQiOS
//
//  Created by Đinh Trần Việt Anh on 27/09/2023.
//

import Foundation

class AddTaskViewModel: ObservableObject {
    @Published var submitButtonDisabled = true
    @Published var title = ""
    @Published var description = ""
    @Published var checklistItems: [ChecklistItem] = []
    func addItem() {
        let newItem = ChecklistItem(title: title, description: description)
        checklistItems.append(newItem)
    }
}
