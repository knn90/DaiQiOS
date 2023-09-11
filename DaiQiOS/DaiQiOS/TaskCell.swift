import SwiftUI


var checklistItems: [ChecklistItem] = [
        ChecklistItem(title: "Task 1", description: "Description 1"),
        ChecklistItem(title: "Task 2", description: "Description 2"),
        ChecklistItem(title: "Task 3", description: "Description 3")
    ]
    
struct TaskCell: View {
    let index: Int
    var body: some View {
        HStack {
                Image(systemName: checklistItems[index].isChecked ? "checkmark.square.fill" : "square")
                    .onTapGesture {
                        checklistItems[index].isChecked.toggle()
                    }
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(checklistItems[index].title)
                        .font(.headline)
                    
                    Text(checklistItems[index].description)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
            }
        }
    }
    
    struct TaskCell_Previews: PreviewProvider {
        static var previews: some View {
            TaskCell(index: 0)
        }
    }

