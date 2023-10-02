import SwiftUI

@main
struct DaiQiOSApp: App {
    @State var lastDay: Date = Date()
    @State var isToday = false
    @State var selectedTime = 8
    @StateObject var listViewModel: ListViewModel = ListViewModel()
    @StateObject var addTaskViewModel: AddTaskViewModel = AddTaskViewModel()
    @StateObject var editTaskViewModel: EditTaskViewModel = EditTaskViewModel()
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                if isToday {
                    TodayChecklist()
                        .environmentObject(listViewModel)
                        .environmentObject(addTaskViewModel)
                        .environmentObject(editTaskViewModel)
                } else {
                   TodayChecklist()
                        .environmentObject(listViewModel)
                        .environmentObject(addTaskViewModel)
                        .environmentObject(editTaskViewModel)
                    
                }
            }
            .onReceive(NotificationCenter.default.publisher(for: UIApplication.willResignActiveNotification)) { _ in
                UserDefaults.standard.set(Date(), forKey: "lastDay")
            }
            .onReceive(NotificationCenter.default.publisher(for: UIApplication.willEnterForegroundNotification)) { _ in
                if let tempDate = UserDefaults.standard.object(forKey: "lastDay") as? Date {
                    if Calendar.current.isDateInToday(tempDate) {
                        self.isToday = true
                        if let thisHour = Calendar.current.dateComponents([.hour], from: Date()).hour {
                            if thisHour >= self.selectedTime {
                                self.resetAppState()
                            }
                        }
                    } else {
                        self.resetAppState()
                    }
                } else {
                    self.resetAppState()
                }
            }
        }
    }
    
    private func resetAppState() {
        self.isToday = false
        self.lastDay = Date()
        UserDefaults.standard.removeObject(forKey: "lastDay")
    }
}
