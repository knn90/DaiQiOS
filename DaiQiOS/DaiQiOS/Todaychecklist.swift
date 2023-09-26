import SwiftUI

struct TodayChecklist: View {
    @StateObject private var viewModel = TodayChecklist.ViewModel()
    @State private var showingSheet = false
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(viewModel.items.indices, id: \.self) { (index: Int) in
                        NavigationLink(destination: EditTask(checklistItem: $viewModel.items[index])) {
                            TaskCell(checklistItem: viewModel.items[index])
                        }
                    }
                    .onDelete(perform: { indexSet in
                        delete(indexSet: indexSet)
                        
                    })
                    .onMove(perform: { indices, newOffset in
                        move(indices: indices, newOffset: newOffset)
                        
                    })}
                .navigationBarItems(trailing: EditButton())
                .accentColor(.purple)
                .listStyle(InsetGroupedListStyle())
                .navigationTitle("Today Checklist")
                Spacer()
                addTaskButton()
            }
        }   .sheet(isPresented: $showingSheet, content: {
            AddTask { checklistItem in
                viewModel.append(checklistItem)
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

    private func delete(indexSet: IndexSet) {
        viewModel.removeItem(at: indexSet.first ?? 0)
    }

    private func move(indices: IndexSet, newOffset: Int) {
        viewModel.moveItem(fromOffsets: indices, toOffset: newOffset)
    }

    struct TodayChecklist_Previews: PreviewProvider {
        static var previews: some View {
            TodayChecklist()
        }
    }
}
