//
//  ContentView.swift
//  Flowchart
//
//  Created by Joshua Hoffman on 8/24/20.
//

import SwiftUI

struct ChartListView: View {
    var body: some View {
        NavigationView {
            List {
                NavigationLink(destination: FlowchartView()) {
                    Text("Test")
                }
            }
            .navigationTitle("My Flowcharts")
            .navigationBarItems(trailing: Button(action: {}, label: {
                Image(systemName: "plus.circle.fill").font(.title)
            }))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ChartListView()
    }
}
