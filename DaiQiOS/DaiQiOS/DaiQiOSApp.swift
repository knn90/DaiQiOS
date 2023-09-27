//
//  DaiQiOSApp.swift
//  DaiQiOS
//
//  Created by Khoi Nguyen on 08/09/2023.
//

import SwiftUI

@main
struct DaiQiOSApp: App {
    
  @StateObject  var listViewModel: ListViewModel = ListViewModel()
    @StateObject  var addTaskViewModel: AddTaskViewModel = AddTaskViewModel()
    @StateObject  var editTaskViewModel: EditTaskViewModel = EditTaskViewModel()
    var body: some Scene {
        WindowGroup {
            NavigationView {
                TodayChecklist()
            }
            .environmentObject(listViewModel)
            .environmentObject(addTaskViewModel)
            .environmentObject(editTaskViewModel)
        }
    }
}
