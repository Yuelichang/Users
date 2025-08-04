//
//  UserListView.swift
//  Users
//
//  Created by Yü Li Chang on 02.08.25.
//

import SwiftUI

struct UserListView: View {
    var body: some View {
        NavigationView() {
            List(Mockdata.users){ user in
                UserRow(users: user)
            }
            .navigationTitle("Users")
        }
    }
}

#Preview {
    UserListView()
}
