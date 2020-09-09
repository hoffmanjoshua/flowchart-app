////
////  FlowchartManager.swift
////  Flowchart
////
////  Created by Joshua Hoffman on 9/9/20.
////
//
//import Foundation
//import SwiftUI
//import CoreData
//
//class FlowchartManager: ObservableObject {
//
//    
//    @Environment(\.managedObjectContext) var moc
//
//    @FetchRequest(
//        entity: FlowchartItem.entity(),
//        sortDescriptors: [NSSortDescriptor(key: "pos", ascending: true)],
//        predicate: nil) var data: FetchedResults<FlowchartItem>
//    
//    func addEntry(content: String) -> Bool {
//        let newItem = FlowchartItem(context: moc)
//            newItem.content = "New Task"
//        newItem.pos = Int16(data.count)
//            newItem.id = UUID()
//            do {
//              try self.moc.save()
//              print("saved new item")
//                return true
//             } catch {
//              print(error.localizedDescription)
//                return false
//              }
//    }
//    
//    func updateEntry(pos: Int16, content: String) -> Bool {
//            let item = data.first(where: {$0.pos == pos})
//        item?.content = content
//            do {
//              try self.moc.save()
//              print("saved new item")
//                return true
//             } catch {
//              print(error.localizedDescription)
//                return false
//              }
//    }
//    
//    func removeEntry(pos: Int16) -> Bool {
//        guard let item = data.first(where: {$0.pos == pos}) else { return false }
//        moc.delete(item)
//        for i in Int(pos)..<data.count {
//            data.first(where: {$0.pos == i})?.pos -= 1;
//        }
//        do {
//            try moc.save()
//            return true
//        } catch {
//            return false
//        }
//    }
//    
//    func moveEntryUp(pos: Int16) -> Bool {
//        if pos > 0 {
//            let element = data.first(where: {$0.pos == pos})
//            let swapElement = data.first(where: {$0.pos == pos - 1})
//            element?.pos -= 1
//            swapElement?.pos += 1
//        }
//        do {
//            try moc.save()
//            return true
//        } catch {
//            return false
//        }
//    }
//    
//    func moveEntryDown(pos: Int16) -> Bool {
//        if pos > 0 {
//            let element = data.first(where: {$0.pos == pos})
//            let swapElement = data.first(where: {$0.pos == pos + 1})
//            element?.pos += 1
//            swapElement?.pos -= 1
//        }
//        do {
//            try moc.save()
//            return true
//        } catch {
//            return false
//        }
//    }
//}
