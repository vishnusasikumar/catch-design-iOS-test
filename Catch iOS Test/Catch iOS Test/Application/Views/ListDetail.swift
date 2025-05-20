//
//  ListDetail.swift
//  Catch iOS Test
//
//  Created by Admin on 20/05/2025.
//

import SwiftUI

struct ListDetail: View {
    var item: Item

    var body: some View {
        ScrollView {

            VStack(alignment: .leading) {
                HStack {
                    Text(item.subtitle)
                    Spacer()
                }
                .font(.subheadline)
                .foregroundStyle(.secondary)

                Divider()
                 
                Text(item.content)
            }
            .padding()
        }
        .navigationTitle(item.title)
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    let modelData = ModelData()
    ListDetail(item: modelData.items[0])
}
