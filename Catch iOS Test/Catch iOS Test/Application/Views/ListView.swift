//
//  ListView.swift
//  Catch iOS Test
//
//  Created by Admin on 20/05/2025.
//

import SwiftUI

struct ListView: View {
    @ObservedObject var viewModel: ListViewModel
    @State private var selectedItem: Item?

    var body: some View {
        ZStack {
            switch viewModel.state {
            case .refresh, .loading:
                ActivityIndicator()
                    .frame(width: 100, height: 100)
                    .foregroundColor(.orange)
            case .failed:
                ErrorView(listViewModel: viewModel)
            case .idle, .loaded:
                NavigationStack {
                        List(selection: $selectedItem) {
                            ForEach(viewModel.items) { item in
                                NavigationLink {
                                    ListDetail(item: item)
                                } label: {
                                    ListRowView(item: item)
                                }
                                .tag(item.title)
                                .listRowSeparator(.hidden)
                            }
                        }
                        .refreshable {
                            await viewModel.refresh()
                        }
                        .animation(.default, value: viewModel.items)
                        .navigationTitle(viewModel.title)
                        .accessibilityLabel(Text("List of data"))
                        .accessibilityHint(Text("Show a list of data"))
                        .accessibilityIdentifier(ListViewModel.ViewID.mainList.rawValue)
                    }
            }
        }
        .onAppear {
            Task {
                await viewModel.getNextItems()
            }
        }
    }
}

#Preview {
    let viewModel = ListViewModel(getItemsUseCase: GetListsUseCase(repo: ListRepository(service: NetworkService())))
    ListView(viewModel: viewModel)
}
