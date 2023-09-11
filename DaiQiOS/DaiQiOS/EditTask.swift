import SwiftUI

struct EditTask: View {
    @State private var title = ""
    @State private var text = ""
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                HStack {
                    Text("Title")
                        .font(.headline)
                        .padding(.trailing, 8)
                    
                    TextField("Enter title", text: $title)
                        .padding()
                        .border(Color.gray, width: 1)
                        .cornerRadius(5)
                }
                
                HStack {
                    Text("Description")
                        .font(.headline)
                        .padding(.trailing, 8)
                    
                    TextEditor(text: $text)
                        .frame(height: 200)
                        .border(Color.gray, width: 1)
                        .cornerRadius(5)
                }
                
                Spacer()
            }
            .padding()
            .navigationBarTitle("Edit Task", displayMode: .inline)
        }
    }
}

struct EditTask_Previews: PreviewProvider {
    static var previews: some View {
        EditTask()
    }
}
