//
//  UserRow.swift
//  Users
//
//  Created by Yü Li Chang on 04.08.25.
//

import SwiftUI

struct UserRow: View {
    let users: User
    @ObservedObject var viewModel = UserListViewModel()
    var body: some View {
        HStack{
            AsyncImage(url: URL(string: users.picture.thumbnail)) { result in
                if let image = result.image {
                    image
                        .resizable()
                        .clipShape(.circle)
                        .frame(width: 50, height: 50)
                } else if result.error != nil {
                    Image(systemName: "person.crop.circle")
                        .resizable()
                        .clipShape(.circle)
                        .frame(width: 50, height: 50)
                } else {
                    ProgressView()
                        .progressViewStyle(.circular)
                        .scaleEffect(1.2)
                        .frame(width: 50, height: 50)
                }
            }
            VStack(alignment: .leading, spacing: 5){
                Text(users.name.first)
                Text(users.name.last)
                    .bold()
            }
            Spacer()
        }
    }
}

#Preview {
    UserRow(users: Mockdata.sampleUser)
}
