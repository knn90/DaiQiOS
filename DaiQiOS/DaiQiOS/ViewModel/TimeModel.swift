//
//  TimeModel.swift
//  DaiQiOS
//
//  Created by Đinh Trần Việt Anh on 02/10/2023.
//

import Foundation
 
class TimeModel: ObservableObject {
    
    @Published var lastDay: Date = Date()
    @Published var isToday = false
    
    
}
