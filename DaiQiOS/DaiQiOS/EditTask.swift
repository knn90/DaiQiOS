//
//  EditTask.swift
//  DaiQiOS
//
//  Created by Đinh Trần Việt Anh on 11/09/2023.
//

import SwiftUI

@State private var editTitle: String = ""

struct EditTask: View {
    var body: some View {
                TextField(
                "Title",
                text: $editTitle
            )
        }
    }
    
    struct EditTask_Previews: PreviewProvider {
        static var previews: some View {
            EditTask()
        }
    }
}
