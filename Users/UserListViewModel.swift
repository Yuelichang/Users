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
                    alertItem = AlertContext.InvalidURL
                case .InvalidResponse:
                    alertItem = AlertContext.InvalidResponse
                case .InvalidData:
                    alertItem = AlertContext.InvalidData
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
}
