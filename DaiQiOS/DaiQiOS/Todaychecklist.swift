import SwiftUI

struct TodayChecklist: View {
    @State private var checklistItems: [ChecklistItem] = [
        ChecklistItem(title: "Task 1", description: "Description 1"),
        ChecklistItem(title: "Task 2", description: "Description 2"),
        ChecklistItem(title: "Task 3", description: "Description 3")
    ]
    
    var body: some View {
        ZStack {
            VStack{
                NavigationView {
                    NavigationLink(destination: Text("Second View")) {
                        Text("Quest")
                    }
                }.frame(height: 100)
                    .font(.title)
                
                List {
                    Text("Today Checklist")
                        .font(.title)
                        .bold()
                    ForEach(checklistItems.indices, id: \.self) { index in
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
                addTaskButton()
            }
            
        }
        .listStyle(PlainListStyle())
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
}

struct TodayChecklist_Previews: PreviewProvider {
    static var previews: some View {
        TodayChecklist()
    }
}

