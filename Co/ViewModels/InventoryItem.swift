//
//  InventoryItem.swift
//  Co
//
//  Created by A on 06/03/2025.
//

import Foundation

struct InventoryItem: Identifiable {
    let id = UUID()
    var name: String
    var quantity: Int
    var unit: String
    var price: Double
}

class InventoryViewModel: ObservableObject {
    @Published var items: [InventoryItem] = [
        InventoryItem(name: "商品A", quantity: 100, unit: "个", price: 10.0),
        InventoryItem(name: "商品B", quantity: 50, unit: "箱", price: 50.0),
        InventoryItem(name: "商品C", quantity: 200, unit: "公斤", price: 5.0)
    ]
}
