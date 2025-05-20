//
//  ListViewModel.swift
//  Catch iOS Test
//
//  Created by Admin on 20/05/2025.
//

import SwiftUI

class ListViewModel: ObservableObject {
    
    enum ViewState {
        case idle
        case loading
        case loaded
        case failed
        case refresh
    }
    
    enum ViewID: String {
        case mainList
        case refreshButton
    }
    
    @Published var items: [Item] = []
    @Published private(set) var state = ViewState.idle
    private var getItemsUseCase: GetListsUseCaseProtocol
    
    init(getItemsUseCase: GetListsUseCaseProtocol) {
        self.getItemsUseCase = getItemsUseCase
    }
    
    @MainActor
    func getNextItems() async {
        state = .loading
        Task {
            let array = await getItemsUseCase.getListItems()
            if array.count <= 0 {
                self.state = .failed
            } else {
                self.items = array
                self.state = .loaded
            }
        }
    }
    
    @MainActor
    func refresh() async {
        await getNextItems()
    }
    
    var title: String {
        "List of Contents"
    }
}
