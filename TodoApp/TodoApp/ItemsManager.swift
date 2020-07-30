//
//  ItemsManager.swift
//  TodoApp
//
//  Created by Marina Beatriz Santana de Aguiar on 30.07.20.
//  Copyright © 2020 Marina Beatriz Santana de Aguiar. All rights reserved.
//

import SwiftUI

class ItemsManager: ObservableObject {
    @Published var items = Items()
    
    func addNewItem(withContent content: String) {
        items.appendToItems(withContent: content)
    }
    
    func retrieveAllItems() -> [Items.Item] { items.getAllItems() }
}
