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
                                    FlowchartStepCardView(entry: entry, model: data, modalState: $editModalOpen, selectedPos: $selectedPos)
                                }
                                AddNewStepButtonView(model: data, button: $editModalOpen)
                            }
                        }
                    }
                    
                    if editModalOpen {
                        EditOverlayModalView(editModalOpen: $editModalOpen, model: data, position: selectedPos)
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


