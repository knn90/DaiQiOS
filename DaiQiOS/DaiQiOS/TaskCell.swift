import SwiftUI
struct TaskCell: View {
    let checklistItem : ChecklistItem
    var body: some View {
        
        HStack {
            Image(systemName: checklistItem.isChecked ? "checkmark.square.fill" : "square")
                .onTapGesture {}
            
            VStack(alignment: .leading, spacing: 4) {
                Text(checklistItem.title)
                    .font(.headline)
                
                Text(checklistItem.description)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
        }
    }
}

struct TaskCell_Previews: PreviewProvider {
    static var previews: some View {
        TaskCell(checklistItem: ChecklistItem(title: "title", description: "description"))
    }
}

