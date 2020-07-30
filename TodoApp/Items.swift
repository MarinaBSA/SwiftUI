//
//  Items.swift
//  TodoApp
//
//  Created by Marina Beatriz Santana de Aguiar on 30.07.20.
//  Copyright © 2020 Marina Beatriz Santana de Aguiar. All rights reserved.
//

import Foundation

struct Items {
    private var allItems = [Item]()
    
    func getAllItems() -> [Item] { allItems }
    
    mutating func appendToItems(withContent content: String) {
        allItems.append(Item(rawValue: content))
    }
    
    struct Item: Identifiable {
        let id = UUID()
        let rawValue: String
    }
}
