//
//  UserListView.swift
//  Users
//
//  Created by Yü Li Chang on 02.08.25.
//

import SwiftUI

struct UserListView: View {
    
    @ObservedObject var viewModel = UserListViewModel()
    
    var body: some View {
        ZStack {
            NavigationView() {
                if viewModel.isLoading {
                    LoadingView()
                } else {
                    List{
                        ForEach(viewModel.users?.results ?? []) { user in
                            Button(action: {
                                viewModel.selectedUser = user
                            }) {
                                HStack {
                                    UserRow(users: user)
                                }
                                .contentShape(Rectangle())
                            }
                            .buttonStyle(.plain)
                        }
                        .onDelete(perform: viewModel.deleteUser
                        )
                        .navigationTitle("Users")
                    }
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
                    .zIndex(1)
            }
        }
    }
}

#Preview {
    UserListView()
}
