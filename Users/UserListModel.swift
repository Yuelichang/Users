//
//  UserListModel.swift
//  Users
//
//  Created by Yü Li Chang on 04.08.25.
//

import Foundation
import SwiftUI

@MainActor
final class UserListModel: ObservableObject{
    @Published var users: UserResponse?
    @Published var alertItem: AlertItem?
    @Published var isLoading = false
    
 
    func getUsers() async {
        do {
            isLoading = true
            defer {isLoading = false}
            let users = try await WebService.getUsers()
                self.users = users
        } catch {
            print("Error caught: \(error)")
            if let userError = error as? UserErrors {
                switch userError {
                case .InvalidURL:
                    self.alertItem = AlertContext.InvalidURL
                case .InvalidResponse:
                    self.alertItem = AlertContext.InvalidResponse
                case .InvalidData:
                    self.alertItem = AlertContext.InvalidData
                }
            } else {
                self.alertItem = AlertItem(
                    title: Text("Unknown Error"),
                    message: Text(error.localizedDescription),
                    dismissButton: .default(Text("OK"))
                )
            }
        }
    }
}
