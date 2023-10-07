import SwiftUI

struct TodayChecklist: View {
    
    @EnvironmentObject var listViewModel: ListViewModel
    
    @State private var showingSheet = false
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(Array(listViewModel.checklistItems.enumerated()), id: \.element.id) { (index, item) in
                        NavigationLink(destination: EditTask(checklistItem: $listViewModel.checklistItems[index])) {
                            TaskCell(checklistItem: item)
                        }
                    }
                    .onDelete(perform: listViewModel.delete)
                    .onMove(perform: listViewModel.move)}
                .navigationBarItems(trailing: EditButton())
                .accentColor(.purple)
                .listStyle(InsetGroupedListStyle())
                addTaskButton()
            }
        }
        //        .onAppear {
        //            listViewModel.resetIfNewDay()
        //        }
        .navigationTitle("Today Checklist")
        .sheet(isPresented: $showingSheet, content: {
            AddTask { checklistItem in
                listViewModel.checklistItems.append(checklistItem)
                showingSheet.toggle()
            }
        })
    }
    @ViewBuilder
    private func addTaskButton() -> some View {
        HStack {
            Button(action: {
                showingSheet.toggle()
                
            }) {
                Image(systemName: "plus")
                    .font(.system(size: 24))
                    .frame(minWidth: 64, minHeight: 64)
                    .background(Color.purple.opacity(0.3))
                    .foregroundColor(.white)
                    .clipShape(Circle())
                    .padding()
            }
        }
    }
    private func getIndex(for item: ChecklistItem) -> Int? {
        return listViewModel.checklistItems.firstIndex { $0.id == item.id }
    }

    struct TodayChecklist_Previews: PreviewProvider {
        static var previews: some View {
            NavigationView {
                TodayChecklist()
            }
            .environmentObject(ListViewModel())
        }
    }
}
