import SwiftUI

struct EditTask: View {
    @State private var title = ""
    @State private var text = ""
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                HStack {
                    TextField("Enter title", text: $title)
                        .padding()
                        .cornerRadius(5)
                }
                
                HStack {
                   TextEditor(text: $text)
                        .frame(height: 200)
                        .border(Color.gray, width: 1)
                        .cornerRadius(5)
                }
                Button(action: {}) {
                    Text("Submit")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.purple.opacity(0.3))
                        .cornerRadius(20)
                }
                .frame(maxWidth: .infinity)
                
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
