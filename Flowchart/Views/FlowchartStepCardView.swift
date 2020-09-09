//
//  FlowchartStepCardView.swift
//  Flowchart
//
//  Created by Joshua Hoffman on 9/9/20.
//

import SwiftUI

struct FlowchartStepCardView: View {

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
                                    .background( RoundedRectangle(cornerRadius: 25).foregroundColor(entry.completed ? .completedGreen : Color(UIColor.tertiarySystemFill)))
                                    .shadow(radius: 10)

                                VStack{
                                    Text(entry.content ?? "n/a")
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
