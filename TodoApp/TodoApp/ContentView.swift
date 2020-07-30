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
    @State var showDeleteAlert = false
    @State var deleteItemIndex: IndexSet? // can only change values in this struct if they have the property wrapper @State

    var body: some View {
        let newItem = { self.placeholder }
        let allItems = { self.itemsManager.retrieveAllItems() }
        
        return NavigationView {
            VStack {
                TextField("Insert todo. Eg.: Buy Apples", text: $placeholder, onCommit: {
                    self.itemsManager.addNewItem(withContent: newItem())
                    self.placeholder = ""
                })
                    .padding(.all)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .multilineTextAlignment(.center)
                List(content: {     //Equivalent of UITableView
                    ForEach(allItems()) { item in
                        // ForEach can only iterate over unique items and return items that conform to the View protocol
                        // Items.Item -> conforms to Identifiable in order to be unique
                        // Use ItemView to create a View with the string as content in order to return something that conforms to the View protocol
                        return ItemView(rawValue: item.rawValue)
                    }
                    .onDelete(perform: deleteItem)
                    .alert(isPresented: $showDeleteAlert) {
                        Alert(title: Text("Warning"), message: Text("This item will be deleted"), primaryButton: .cancel(),
                              secondaryButton: .destructive(Text("OK")) {
                                if let index = self.deleteItemIndex {
                                    self.itemsManager.deleteItem(index: index)
                                }
                            }
                        )
                    }
                })
            }
            .navigationBarTitle(Text("To Do"))

        }
      
    }
    
    func deleteItem(index: IndexSet) {
        showDeleteAlert = true
        deleteItemIndex = index
    }
    
}

struct ItemView: View {
    let rawValue: String
    var body: some View {
        Text(rawValue)
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
