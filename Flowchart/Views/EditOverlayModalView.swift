//
//  EditOverlayModalView.swift
//  Flowchart
//
//  Created by Joshua Hoffman on 9/9/20.
//

import SwiftUI

struct EditOverlayModalView: View {

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
                    .fill(Color(UIColor.tertiarySystemBackground))
                    .shadow(radius: 10)


                TextEditor(text: $text)
                    .background(Color(UIColor.tertiarySystemBackground))
                    .padding()
                    .clipShape(RoundedRectangle(cornerRadius: 25))
                    .onAppear {
                        text = model.first(where: { $0.pos == position })?.content ?? ""
                    }
            }
            .frame(width: 200, height: 200)
        }
        .onAppear() {
            UITextView.appearance().backgroundColor = .clear
        }
    }
}
