//
//  ContentView.swift
//  TodoApp
//
//  Created by Marina Beatriz Santana de Aguiar on 30.07.20.
//  Copyright © 2020 Marina Beatriz Santana de Aguiar. All rights reserved.
//

import SwiftUI


struct ContentView: View {
    @State var placeholder = ""
    @ObservedObject var itemsManager = ItemsManager()

    var body: some View {
        let newItem = { self.placeholder }
        return VStack {
            TextField("Insert todo. Eg.: Buy Apples", text: $placeholder, onCommit: {
                self.itemsManager.addNewItem(withContent: newItem())
                self.placeholder = ""
            })
                .padding(.all)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .multilineTextAlignment(.center)
            ItemsList(items: itemsManager.retrieveAllItems())
        }
    }
}

struct ItemsList: View {
    var items: [Items.Item]
    var body: some View {
        
        return List(content: {
            ForEach(items) { item in
                // ForEach can only iterate over unique items and return items that conform to the View protocol
                // Items.Item -> conforms to Identifiable in order to be unique
                // Use ItemView to create a View with the string as content in order to return something that conforms to the View protocol
                return ItemView(rawValue: item.rawValue)
            }
        })
    }
    
    struct ItemView: View {
        let rawValue: String
        var body: some View {
            Text(rawValue)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}