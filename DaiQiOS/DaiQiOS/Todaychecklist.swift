import SwiftUI

struct TodayChecklist: View {
    
    var checklistItems: [ChecklistItem] = [
        ChecklistItem(title: "Task 1", description: "Description 1"),
        ChecklistItem(title: "Task 2", description: "Description 2"),
        ChecklistItem(title: "Task 3", description: "Description 3")
    ]
    
    var body: some View {
        NavigationView {
            ZStack {
                List(checklistItems) { item in
                    NavigationLink(destination:EditTask() ){TaskCell(checklistItem: item)}
                }
                addTaskButton()
            }
            .navigationTitle("Today Checklist")
        }
        
    }
    @ViewBuilder
    private func addTaskButton() -> some View {
        Button(action: {}) {
            Image(systemName: "plus")
                .font(.system(size: 24))
                .frame(width: 64, height: 64)
                .background(Color.purple.opacity(0.3))
                .foregroundColor(.white)
                .clipShape(Circle())
        }
    }
    
    struct TodayChecklist_Previews: PreviewProvider {
        static var previews: some View {
            TodayChecklist()
        }
    }
    
}
