//
//  UserListView.swift
//  Users
//
//  Created by Yü Li Chang on 02.08.25.
//

import SwiftUI

struct UserListView: View {
    
    @ObservedObject var viewModel = UserListModel()
    
    
    var body: some View {
        NavigationView() {
            if viewModel.isLoading {
                LoadingView()
            } else {
                List(viewModel.users?.results ?? []){ user in
                    UserRow(users: user)
                }
                .navigationTitle("Users")
            }
            }.task {
                await viewModel.getUsers()
            }
        
                .alert(item: $viewModel.alertItem) { alertItem in
                    Alert(title: alertItem.title,
                          message: alertItem.message,
                          dismissButton: alertItem.dismissButton)
                }
    }
}

#Preview {
    UserListView()
}
