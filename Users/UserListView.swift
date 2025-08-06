//
//  UserListView.swift
//  Users
//
//  Created by Yü Li Chang on 02.08.25.
//

import SwiftUI

struct UserListView: View {
    
    @ObservedObject var viewModel = UserListViewModel()
    @State var searchTerm = ""
    
    var body: some View {
        ZStack {
            NavigationStack() {
                if viewModel.isLoading {
                    LoadingView()
                } else {
                    List{
                        ForEach(filteredUsers) { user in
                            Button(action: {
                                viewModel.selectedUser = user
                            }) {
                                HStack {
                                    UserRow(users: user)
                                }
                                .contentShape(Rectangle())
                            }
                            .contextMenu {
                                Button {
//                                    if let index = viewModel.users?.results.firstIndex(of: user) {
//                                        viewModel.deleteUser(at: IndexSet(integer: index))
//                                    }
                                } label: {
                                    Text("Delete")
                                }
                            }
                            .buttonStyle(.plain)
                        }
                        .onDelete(perform: viewModel.deleteUser
                        )
                    }
                    .navigationTitle("Users")
                    .searchable(text: $searchTerm, prompt: "Search user by last name")
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
    var filteredUsers: [User] {
        guard !searchTerm.isEmpty else { return viewModel.users?.results ?? []}
        return viewModel.users?.results.filter {
            $0.name.last.localizedCaseInsensitiveContains(searchTerm)
        } ?? []
    }
}

#Preview {
    UserListView()
}
