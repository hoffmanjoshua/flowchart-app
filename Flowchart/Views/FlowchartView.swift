//
//  FlowchartView.swift
//  Flowchart
//
//  Created by Joshua Hoffman on 8/24/20.
//

import SwiftUI

struct FlowchartView: View {
    
    @State var data: [ChartItem] = [ChartItem.init(content: "0", pos: 0), ChartItem.init(content: "1", pos: 1)]
    @State var editModalOpen = false
    @State var selectedPos = -1
    
    var body: some View {
        Group {
            ZStack {
                VStack() {
                    ScrollView {
                        VStack {
                            ForEach(data, id: \.id) { entry in
                                FlowchartStepCard(data: entry, list: $data, modalState: $editModalOpen, selectedPos: $selectedPos)
                            }
                            AddNewStepButton(data: $data, button: $editModalOpen)
                        }
                    }
                }
                .navigationBarTitle("TaskFlow")
                
                if editModalOpen {
                    EditOverlayModal(editModalOpen: $editModalOpen, list: $data, position: selectedPos)
                }
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
    
    var data: ChartItem
    
    @Binding var list: [ChartItem]
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
                                    .strokeBorder(Color.blue, lineWidth: selectedPos == data.pos ? 2 : 0)
                                    .background(RoundedRectangle(cornerRadius: 25).foregroundColor(Color(UIColor.secondarySystemFill)))
                                    
                                    .shadow(radius: 10)
                                
                                VStack{
                                    Text(data.content)
                                    Text("Position: \(data.pos)")
                                }.padding()
                            }.frame(minWidth: 300, maxWidth: 300, minHeight: 200)
                            .onTapGesture(count: 1, perform: {
                                withAnimation {
                                    if selectedPos == data.pos {
                                        selectedPos = -1
                                    } else {
                                        selectedPos = data.pos
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
                    
                    if selectedPos == data.pos {
                        ModifyButtonsOverlayView(list: $list, modalState: $modalState, data: data)
                    }
                    
                    
                }
            }
            
        }
    }
}

struct AddNewStepButton: View {
    @Binding var data: [ChartItem]
    @Binding var button: Bool
    
    var body: some View {
        VStack {
            Image(systemName: "plus.circle")
                .font(.system(size: 40, weight: .semibold))
                .foregroundColor(Color(UIColor.systemBlue))
                .padding()
        }
        .onTapGesture {
            data.append(ChartItem(content: "Tap to Edit", pos: data.count))
        }
    }
}

struct ModifyButtonsOverlayView: View {
    
    @Binding var list: [ChartItem]
    @Binding var modalState: Bool
    
    var data: ChartItem
    
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
                            if data.pos > 0 {
                                let element = list.remove(at: data.pos)
                                list.insert(element, at: data.pos - 1)
                                list[data.pos - 1].pos -= 1
                                list[data.pos ].pos += 1
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
                            if data.pos >= 0 && data.pos < list.count - 1 {
                                let element = list.remove(at: data.pos)
                                list.insert(element, at: data.pos + 1)
                                list[data.pos].pos -= 1
                                list[data.pos + 1].pos += 1
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
                            list.removeAll(where: {$0.id == data.id})
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

struct EditOverlayModal: View {
    
    @Binding var editModalOpen: Bool
    @Binding var list: [ChartItem]
    
    
    @State var text = ""
    
    var position: Int
    
    var body: some View {
        ZStack {
            
            Color.black
                .opacity(0.7)
                .edgesIgnoringSafeArea(.all)
                .onTapGesture(count: 1, perform: {
                    withAnimation {
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
            }
            .frame(width: 200, height: 200)
        }
    }
}
