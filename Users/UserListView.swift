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
        ZStack {
            NavigationView() {
                if viewModel.isLoading {
                    LoadingView()
                } else {
                    
                    List(viewModel.users?.results ?? []) { user in
                        UserRow(users: user)
                            .onTapGesture {
                                viewModel.selectedUser = user
                            }
                    }.navigationTitle("Users")
                    
                    
//                    List(viewModel.users?.results ?? []) { user in
//                        NavigationLink(destination: UserDetailsView(users: user)) {
//                            UserRow(users: user)
//                        }
//                    }
//                    .navigationTitle("Users")
                    
                }
            }.task {
                await viewModel.getUsers()
            }
            .alert(item: $viewModel.alertItem) { alertItem in
                Alert(title: alertItem.title,
                      message: alertItem.message,
                      dismissButton: alertItem.dismissButton)
            
            }
            .blur(radius: viewModel.selectedUser == nil ? 0 : 5)
            
            if let user = viewModel.selectedUser {
                Color.black.opacity(0.5)
                    .ignoresSafeArea()
                    .onTapGesture { viewModel.selectedUser = nil }

                UserDetailsView(users: user, onDismiss: {viewModel.selectedUser = nil})
                    .transition(.scale)
                    .zIndex(1)
            }
        }
    }
}

#Preview {
    UserListView()
}
