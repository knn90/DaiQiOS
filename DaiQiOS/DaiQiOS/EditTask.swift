import SwiftUI

struct EditTask: View {
    @State private var title = ""
    @State private var text = ""
    var checklistItem : ChecklistItem
    var body: some View {
     
        NavigationView {
            
            VStack(alignment: .leading) {
                HStack {
                    TextField(checklistItem.title, text: $title)
                }
                Divider()
                HStack {
                    TextField(checklistItem.description,text: $text,axis: .vertical)
                        .frame(height: 100)
                        .cornerRadius(5)
                        .font(.body)
                }
                Spacer()
                Button(action: {}) {
                    Text("Submit")
                        .font(.headline)
                        .foregroundColor(.blue)
                        .padding()
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(30)
                        .shadow(color:.black,radius: 100)
                    
                }
                .frame(maxWidth: .infinity)
            }
            .padding()
            
        }
        
    }
}

struct EditTask_Previews: PreviewProvider {
    static var previews: some View {
        EditTask(checklistItem: ChecklistItem(title: "title", description: "description"))
    }
}
