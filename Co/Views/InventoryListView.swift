//
//  InventoryListView.swift
//  Co
//
//  Created by A on 06/03/2025.
//

import SwiftUI

struct InventoryListView: View {
    @ObservedObject var viewModel = InventoryViewModel()
    var body: some View {
        NavigationView {
                    List {
                        ForEach(viewModel.items) { item in
                            NavigationLink(destination: InventoryDetailView(item: item)) {
                                HStack {
                                    Text(item.name)
                                    Spacer()
                                    Text("\(item.quantity) \(item.unit)")
                                }
                            }
                        }
                    }
                    .navigationTitle("库存列表")
                    .toolbar {
                        NavigationLink(destination: InventoryAddView()) {
                            Image(systemName: "plus")
                        }
                    }
                }
    }
}

#Preview {
    InventoryListView()
}
