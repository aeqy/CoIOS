//
//  InventoryDetailView.swift
//  Co
//
//  Created by A on 06/03/2025.
//

import SwiftUI

struct InventoryDetailView: View {
    let item: InventoryItem
    var body: some View {
        VStack(alignment: .leading) {
                    Text(item.name)
                        .font(.title)
                    Text("数量：\(item.quantity) \(item.unit)")
                    Text("价格：\(item.price, specifier: "%.2f") 元")
                    Spacer()
                }
                .padding()
                .navigationTitle("库存详情")
    }
}
