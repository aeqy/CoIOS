//
//  InventoryAddView.swift
//  Co
//
//  Created by A on 06/03/2025.
//

import SwiftUI

struct InventoryAddView: View {
    @Environment(\.presentationMode) var presentationMode
        @ObservedObject var viewModel = InventoryViewModel()
        @State private var name = ""
        @State private var quantity = ""
        @State private var unit = ""
        @State private var price = ""

        var body: some View {
            Form {
                TextField("商品名称", text: $name)
                TextField("数量", text: $quantity)
                    .keyboardType(.numberPad)
                TextField("单位", text: $unit)
                TextField("价格", text: $price)
                    .keyboardType(.decimalPad)
            }
            .navigationTitle("添加库存")
            .toolbar {
                Button("保存") {
                    if let quantity = Int(quantity), let price = Double(price) {
                        let newItem = InventoryItem(name: name, quantity: quantity, unit: unit, price: price)
                        viewModel.items.append(newItem)
                        presentationMode.wrappedValue.dismiss()
                    }
                }
            }
        }
}

#Preview {
    InventoryAddView()
}
