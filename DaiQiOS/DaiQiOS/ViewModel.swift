//
//  ViewModel.swift
//  DaiQiOS
//
//  Created by Đinh Trần Việt Anh on 26/09/2023.
//

import Foundation

extension TodayChecklist {
    @MainActor class ViewModel: ObservableObject {
     @Published var items: [ChecklistItem] = [
            ChecklistItem(title: "Task 1", description: "Description 1"),
            ChecklistItem(title: "Task 2", description: "Description 2"),
            ChecklistItem(title: "Task 3", description: "Description 3")
        ]
        func append(_ item: ChecklistItem) {
                 items.append(item)
             }

             func removeItem(at index: Int) {
                 if items.indices.contains(index) {
                     items.remove(at: index)
                 }
             }

             func moveItem(fromOffsets indices: IndexSet, toOffset newOffset: Int) {
                 items.move(fromOffsets: indices, toOffset: newOffset)
             }
    }
}

