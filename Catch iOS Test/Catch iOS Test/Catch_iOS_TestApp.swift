//
//  Catch_iOS_TestApp.swift
//  Catch iOS Test
//
//  Created by Admin on 20/05/2025.
//

import SwiftUI
import SwiftData

@main
struct Catch_iOS_TestApp: App {
    var body: some Scene {
        WindowGroup {
            ListView(viewModel: ListViewModel(getItemsUseCase: GetListsUseCase(repo: ListRepository(service: NetworkService()))))
        }
    }
}
