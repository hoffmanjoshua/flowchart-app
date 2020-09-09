//
//  FlowchartView.swift
//  Flowchart
//
//  Created by Joshua Hoffman on 8/24/20.
//

import SwiftUI

struct FlowchartView: View {

    
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(
        entity: FlowchartItem.entity(),
        sortDescriptors: [NSSortDescriptor(key: "pos", ascending: true)],
        predicate: nil) var data: FetchedResults<FlowchartItem>
    
    @State var pageReady = false

  
    @State var editModalOpen = false
    @State var selectedPos = -1
    
    var body: some View {
        ZStack {
            NavigationView {
                ZStack {
                    VStack() {
                        ScrollView {
                            VStack {
                                ForEach(data, id: \.id){ entry in
                                    FlowchartStepCard(entry: entry, model: data, modalState: $editModalOpen, selectedPos: $selectedPos)
                                }
                                AddNewStepButton(model: data, button: $editModalOpen)
                            }
                        }
                    }
                    
                    if editModalOpen {
                        EditOverlayModal(editModalOpen: $editModalOpen, model: data, position: selectedPos)
                    }
                }
                .navigationTitle("Flowchart")
            }
        }
    }

}



struct FlowchartView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            FlowchartView()
        }
    }
}

struct FlowchartStepCard: View {

    @Environment(\.managedObjectContext) var moc
    var entry: FlowchartItem
    
    var model: FetchedResults<FlowchartItem>
    @Binding var modalState: Bool
    @Binding var selectedPos: Int

    var body: some View {

        ZStack {
            Group {
                ZStack {
                    HStack {
                        Spacer()
                        VStack {
                            ZStack {
                                RoundedRectangle(cornerRadius: 25)
                                    .strokeBorder(Color.blue, lineWidth: selectedPos == entry.pos ? 2 : 0)
                                    .background(RoundedRectangle(cornerRadius: 25).foregroundColor(Color(UIColor.secondarySystemFill)))

                                    .shadow(radius: 10)

                                VStack{
                                    Text(entry.content ?? "n/a")
                                    Text("Position: \(entry.pos)")
                                }.padding()
                            }.frame(minWidth: 300, maxWidth: 300, minHeight: 200)
                            .onTapGesture(count: 1, perform: {
                                withAnimation {
                                    if selectedPos == entry.pos {
                                        selectedPos = -1
                                    } else {
                                        selectedPos = Int(entry.pos)
                                    }
                                }
                            })
                            Image(systemName: "arrow.down")
                                .font(.system(size: 40, weight: .semibold))
                                .foregroundColor(Color(UIColor.systemGray))
                                .offset(y: -20)
                                .padding(.bottom, -28)
                        }
                        Spacer()
                    }

                    if selectedPos == entry.pos {
                        ModifyButtonsOverlayView(model: model, modalState: $modalState, posSelected: $selectedPos, entry: entry)
                    }


                }
            }

        }
    }
}

struct AddNewStepButton: View {
    var model: FetchedResults<FlowchartItem>
    @Binding var button: Bool
    
    @Environment(\.managedObjectContext) var moc

    var body: some View {
        VStack {
            Image(systemName: "plus.circle")
                .font(.system(size: 40, weight: .semibold))
                .foregroundColor(Color(UIColor.systemBlue))
                .padding()
        }
        .onTapGesture {
            let newItem = FlowchartItem(context: moc)
            newItem.content = "Click to Edit"
            newItem.pos = Int16(model.count)
            newItem.id = UUID()
            do {
                try self.moc.save()
                print("saved new item")
                print(model)
            } catch {
                print(error.localizedDescription)
          }
        }
    }
}

struct ModifyButtonsOverlayView: View {

    var model: FetchedResults<FlowchartItem>
    @Binding var modalState: Bool
    @Binding var posSelected: Int
    @Environment(\.managedObjectContext) var moc

    var entry: FlowchartItem

    var body: some View {
        VStack {
            Spacer()
            HStack {
                ZStack {
                    Circle()
                        .fill(Color(UIColor.gray))
                        .frame(width: 35, height: 35)
                        .shadow(radius: 2)
                    Image(systemName: "arrow.up").foregroundColor(Color(UIColor.systemGray6))
                        .font(.system(size: 20, weight: .semibold))
                        .padding()
                        .onTapGesture(count: 1, perform: {
                            if entry.pos > 0 {
                                let element = model.first(where: {$0.pos == entry.pos})
                                let swapElement = model.first(where: {$0.pos == entry.pos - 1})
                                element?.pos -= 1
                                swapElement?.pos += 1
                            }
                            do {
                                try moc.save()
                            } catch {
                                
                            }
                        })

                }
                .frame(width: 35, height: 35)
                .offset(x: 0, y : 3)
                ZStack {
                    Circle()
                        .fill(Color(UIColor.gray))
                        .frame(width: 35, height: 35)
                        .shadow(radius: 2)
                    Image(systemName: "arrow.down").foregroundColor(Color(UIColor.systemGray6))
                        .font(.system(size: 20, weight: .semibold))
                        .padding()
                        .onTapGesture(count: 1, perform: {
                            if entry.pos >= 0 && entry.pos < model.count - 1 {
                                let element = model.first(where: {$0.pos == entry.pos})
                                let swapElement = model.first(where: {$0.pos == entry.pos + 1})
                                element?.pos += 1
                                swapElement?.pos -= 1
                            }
                            do {
                                try moc.save()
                            } catch {
                                
                            }
                        })

                }
                .frame(width: 35, height: 35)
                .offset(x: 0, y : 3)
                Spacer()
                ZStack {
                    Circle()
                        .fill(Color(UIColor.gray))
                        .frame(width: 40, height: 40)
                        .shadow(radius: 2)
                    Image(systemName: "trash").foregroundColor(Color(UIColor.systemGray6))
                        .font(.system(size: 20, weight: .semibold))
                        .padding()
                        .onTapGesture(count: 1, perform: {
                            let item = model.first(where: {$0.pos == entry.pos})!
                            moc.delete(item)
                            for i in Int(entry.pos)..<model.count {
                                model.first(where: {$0.pos == i})?.pos -= 1;
                            }
                            do {
                                try moc.save()
                            } catch {

                            }
                            posSelected = -1
                        })

                }
                .frame(width: 40, height: 40)
                .offset(x: 0, y : 3)

                ZStack {
                    Circle()
                        .fill(Color(UIColor.gray))
                        .frame(width: 50, height: 50)
                        .shadow(radius: 2)
                    Image(systemName: "square.and.pencil").foregroundColor(Color(UIColor.systemGray6)) .font(.system(size: 25, weight: .semibold))
                        .padding()
                        .onTapGesture(count: 1, perform: {
                            withAnimation {
                                modalState = true
                            }
                        })

                }
                .frame(width: 50, height: 50)
                .offset(x: 0, y : 3)
            }
            .frame(minWidth: 300, maxWidth: 300)
        }
    }
}
//

struct EditOverlayModal: View {

    @Binding var editModalOpen: Bool
    var model: FetchedResults<FlowchartItem>

    @State var text = ""
    @Environment(\.managedObjectContext) var moc

    var position: Int

    var body: some View {
        ZStack {

            Color.black
                .opacity(0.7)
                .edgesIgnoringSafeArea(.all)
                .onTapGesture(count: 1, perform: {
                    withAnimation {
                        let item = model.first(where: {$0.pos == position})
                        item?.content = text
                        do {
                          try self.moc.save()
                          print("saved new item")
                         } catch {
                          print(error.localizedDescription)
                          }
                        text = ""
                        editModalOpen = false
                    }
                })

            Group {
                RoundedRectangle(cornerRadius: 25)
                    .fill(Color(UIColor.white))
                    .shadow(radius: 10)


                TextEditor(text: $text)
                    .background(Color(UIColor.white))
                    .padding()
                    .clipShape(RoundedRectangle(cornerRadius: 25))
                    .onAppear {
                        text = model.first(where: { $0.pos == position })?.content ?? ""
                    }
            }
            .frame(width: 200, height: 200)
        }
    }
}
