//
//  ErrorView.swift
//  Catch iOS Test
//
//  Created by Admin on 20/05/2025.
//

import SwiftUI

struct ErrorView: View {
    @ObservedObject var listViewModel: ListViewModel
    
    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .overlay {
                VStack {
                    Text("Sorry something went wrong, Please try again later")
                        .font(.title3)
                        .fontWeight(.medium)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                    Button("Reload Users") {
                        Task {
                            await listViewModel.refresh()
                        }
                    }
                    .buttonStyle(.bordered)
                }
                
            }
    }
}

#Preview {
    let viewModel = ListViewModel(getItemsUseCase: GetListsUseCase(repo: ListRepository(service: MockService())))
    ErrorView(listViewModel: viewModel)
}
