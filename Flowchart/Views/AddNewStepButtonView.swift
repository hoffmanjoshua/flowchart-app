//
//  AddNewStepButtonView.swift
//  Flowchart
//
//  Created by Joshua Hoffman on 9/9/20.
//

import SwiftUI

struct AddNewStepButtonView: View {
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
            newItem.completed = false
            do {
                try self.moc.save()
                print("saved new item")
            } catch {
                print(error.localizedDescription)
          }
        }
    }
}

