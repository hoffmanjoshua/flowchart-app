//
//  ContentView.swift
//  Flowchart
//
//  Created by Joshua Hoffman on 8/24/20.
//

import SwiftUI
//
//struct ChartListView: View {
//    
//    @Environment(\.managedObjectContext) var moc
//    @FetchRequest(entity: Flowchart.entity(), sortDescriptors: []) var data: FetchedResults<Flowchart>
//    
//    
//    var body: some View {
//        NavigationView {
//            List {
//                ForEach(data, id: \.id) { chart in
//                    NavigationLink(destination: FlowchartView(chartID: chart.id!).environment(\.managedObjectContext, moc)) {
//                        Text(chart.title ?? "Unknown")
//                    }
//                }
//            }
//            .navigationTitle("My Flowcharts")
//            .navigationBarItems(trailing: Button(action: {}, label: {
//                Image(systemName: "plus.circle.fill").font(.title)
//                    .onTapGesture {
//                        let chart = Flowchart(context: moc)
//                        chart.title = "New Chart"
//                        chart.id = UUID()
//                        do {
//                          try self.moc.save()
//                          print("Order saved.")
//                         } catch {
//                          print(error.localizedDescription)
//                          }
//                    }
//            }))
//        }
//    }
//}
//
//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ChartListView()
//    }
//}
