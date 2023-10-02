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

}
