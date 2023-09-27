//
//  EditTaskViewModel.swift
//  DaiQiOS
//
//  Created by Đinh Trần Việt Anh on 27/09/2023.
//

import Foundation

class EditTaskViewModel: ObservableObject {
    @Published private var title = ""
    @Published private var description = ""
    @Published private var submitButtonDisabled = true

}
