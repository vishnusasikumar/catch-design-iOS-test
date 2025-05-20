//
//  ListRowView.swift
//  Catch iOS Test
//
//  Created by Admin on 20/05/2025.
//

import SwiftUI

struct ListRowView: View {
    var item: Item
    
    var body: some View {
        VStack {
            HStack {
                Text(item.title)
                    .font(.title2)
                    .lineLimit(1)
                Spacer()
                Text(item.subtitle)
                    .font(.title3)
                    .lineLimit(1)
                    .foregroundStyle(.secondary)
            }
            Divider()
        }
        .padding(.top, 5)
        .padding(.bottom, 5)
    }
}

#Preview {
    let items = ModelData().items
    return Group {
        ListRowView(item: items[0])
        ListRowView(item: items[1])
    }
}
