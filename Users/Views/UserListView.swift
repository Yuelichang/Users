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
            NavigationStack() {
                if viewModel.isLoading {
                    LoadingView()
                } else {
                    VStack {
                        Picker("Pick Gender", selection: $viewModel.selectedGender) {
                            ForEach(Gender.allCases, id: \.self) {
                                Text($0.rawValue.capitalized)
                            }
                        }
                        .pickerStyle(.segmented)
                        .padding(.horizontal)
                    }
                    List{
                        ForEach(viewModel.filteredUsers) { user in
                            Button(action: {
                                viewModel.selectedUser = user
                            }) {
                                HStack {
                                    UserRow(users: user)
                                }
                                .contentShape(Rectangle())
                            }
                            .buttonStyle(.plain)
                            .swipeActions {
                                Button(role: .destructive) {
                                    viewModel.deleteUser(withId: user.id)
                                } label: {
                                    Label("Delete", systemImage: "trash")
                                }
                            }
                            .contextMenu {
                                Button {
                                    viewModel.deleteUser(withId: user.id)
                                } label: {
                                    Text("Delete")
                                }
                            }
                        }
                    }
                    //                        .onDelete(perform: viewModel.deleteUser)
                    .navigationTitle("Users")
                    .searchable(text: $viewModel.searchTerm, prompt: "Search user by last name")
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
