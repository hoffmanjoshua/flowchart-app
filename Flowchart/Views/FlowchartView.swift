//
//  FlowchartView.swift
//  Flowchart
//
//  Created by Joshua Hoffman on 8/24/20.
//

import SwiftUI

struct FlowchartView: View {
    var body: some View {
        VStack() {
            ScrollView {
                VStack {
                    FlowchartStepCard()
                    FlowchartStepCard()
                    FlowchartStepCard()
                    FlowchartStepCard()
                    FlowchartStepCard()
                    AddNewStepButton()
                }
            }
        }
        .navigationBarTitle("TaskFlow")
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
    
    @State var stepSelected = false
    
    var body: some View {
        
        Group {
            ZStack {
                HStack {
                    Spacer()
                    VStack {
                        ZStack {
                            RoundedRectangle(cornerRadius: 25)
                                .strokeBorder(Color.blue, lineWidth: stepSelected ? 2 : 0)
                                .background(RoundedRectangle(cornerRadius: 25).foregroundColor(Color(UIColor.secondarySystemFill)))
                                
                                .shadow(radius: 10)
                            
                            VStack{
                                Text("Flowchart step content here.")
                            }.padding()
                        }.frame(minWidth: 300, maxWidth: 300, minHeight: 200)
                        .onTapGesture(count: 1, perform: {
                            withAnimation {
                                stepSelected.toggle()
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
                
                if stepSelected {
                    ModifyButtonsOverlayView()
                }
                
                
            }
        }
    }
}

struct AddNewStepButton: View {
    var body: some View {
        VStack {
            Image(systemName: "plus.circle")
                .font(.system(size: 40, weight: .semibold))
                .foregroundColor(Color(UIColor.systemBlue))
                .padding()
        }
    }
}

struct ModifyButtonsOverlayView: View {
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
                    
                }
                .frame(width: 50, height: 50)
                .offset(x: 0, y : 3)
            }
            .frame(minWidth: 300, maxWidth: 300)
        }
    }
}
