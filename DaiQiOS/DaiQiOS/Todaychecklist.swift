import SwiftUI
struct TodayChecklist: View {
    var body: some View {
        ZStack {
            VStack{
                NavigationView {
                    Text("Today Checklist")
                }
                .navigationTitle("Today Checklist")
                .frame(height: 50)
                .font(.title)
                .bold()
                
                List {
                    TaskCell()
                }
                .listStyle(PlainListStyle())
            }
            addTaskButton()
        }
        
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

