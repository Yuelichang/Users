//
//  UserListViewModel.swift
//  Users
//
//  Created by Yü Li Chang on 04.08.25.
//

import Foundation
import SwiftUI

@MainActor
final class UserListViewModel: ObservableObject{
    @Published var users: UserResponse?
    @Published var alertItem: AlertItem?
    @Published var isLoading = false
    @Published var selectedUser: User?
    @Published var searchTerm = ""
    @Published var selectedGender = Gender.all
    
    
    func getUsers() async {
        do {
            isLoading = true
            defer {isLoading = false}
            let users = try await WebService.getUsers()
            self.users = users
        } catch {
            if let userError = error as? UserErrors {
                switch userError {
                case .InvalidURL:
                    self.alertItem = AlertItem(
                        title: AlertContext.InvalidURLTitle,
                        message: AlertContext.InvalidURLMessage,
                        dismissButton: .default(Text("Retry")) {
                            Task {
                                await self.getUsers()
                            }
                        }
                    )
                case .InvalidResponse:
                    self.alertItem = AlertItem(
                        title: AlertContext.InvalidURLTitle,
                        message: AlertContext.InvalidURLMessage,
                        dismissButton: .default(Text("Retry")) {
                            Task {
                                await self.getUsers()
                            }
                        }
                    )
                case .InvalidData:
                    self.alertItem = AlertItem(
                        title: AlertContext.InvalidURLTitle,
                        message: AlertContext.InvalidURLMessage,
                        dismissButton: .default(Text("Retry")) {
                            Task {
                                await self.getUsers()
                            }
                        }
                    )
                case .UnableToComplete:
                    self.alertItem = AlertItem(
                        title: AlertContext.InvalidURLTitle,
                        message: AlertContext.InvalidURLMessage,
                        dismissButton: .default(Text("Retry")) {
                            Task {
                                await self.getUsers()
                            }
                        }
                    )
                }
            } else {
                self.alertItem = AlertItem(
                    title: Text("Unknown Error"),
                    message: Text(error.localizedDescription),
                    dismissButton: .default(Text("Retry")){
                        Task {
                            await self.getUsers()
                        }
                    }
                )
            }
        }
    }
    
    func deleteUser(at offsets: IndexSet) {
        users?.results.remove(atOffsets: offsets)
    }
    
    var filteredUsers: [User] {
        users?.results.filter { user in
            (selectedGender == .all || user.gender == selectedGender) &&
            (searchTerm.isEmpty || user.name.last.localizedCaseInsensitiveContains(searchTerm))
        } ?? []
    }
}
