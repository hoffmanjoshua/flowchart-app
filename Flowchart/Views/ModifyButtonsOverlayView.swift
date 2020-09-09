//
//  ModifyButtonsOverlayView.swift
//  Flowchart
//
//  Created by Joshua Hoffman on 9/9/20.
//

import SwiftUI

struct ModifyButtonsOverlayView: View {

    var model: FetchedResults<FlowchartItem>
    @Binding var modalState: Bool
    @Binding var posSelected: Int
    @Environment(\.managedObjectContext) var moc

    var entry: FlowchartItem

    var body: some View {
        VStack {
            HStack {
                Spacer()
                ZStack {
                    Circle()
                        .fill(Color(UIColor.gray))
                        .frame(width: 35, height: 35)
                        .shadow(radius: 2)
                    Image(systemName: entry.completed ? "arrow.uturn.left" : "checkmark").foregroundColor(Color(UIColor.systemGray6))
                        .font(.system(size: 20, weight: .semibold))
                        .padding()
                        .onTapGesture(count: 1, perform: {
                            let element = model.first(where: {$0.pos == entry.pos})
                            element?.completed.toggle()
                            do {
                                try moc.save()
                            } catch {
                                
                            }
                        })

                }
                .frame(width: 35, height: 35)
                .offset(x: 2, y : -4)
            }
            .frame(minWidth: 300, maxWidth: 300)
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

