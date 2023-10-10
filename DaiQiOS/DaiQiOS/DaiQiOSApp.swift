import SwiftUI
import Firebase

@main
struct DaiQiOSApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

    @StateObject var listViewModel: ListViewModel = ListViewModel()
    @StateObject var addTaskViewModel: AddTaskViewModel = AddTaskViewModel()
    @StateObject var editTaskViewModel: EditTaskViewModel = EditTaskViewModel()
    
    var body: some Scene {
        WindowGroup {
           RootView()
            //                TodayChecklist()
//            .environmentObject(listViewModel)
//            .environmentObject(addTaskViewModel)
//            .environmentObject(editTaskViewModel)
//
        }
        
    }
}
class AppDelegate : NSObject , UIApplicationDelegate {
    func application ( _ application : UIApplication , didFinishLaunchingWithOptions launchOptions : [ UIApplication . LaunchOptionsKey : Any ]? = nil ) -> Bool {
        FirebaseApp . configure ()
        return true
    }
}
