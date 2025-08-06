//
//  UserDetailsView.swift
//  Users
//
//  Created by Yü Li Chang on 05.08.25.
//

import SwiftUI

struct UserDetailsView: View {
    
    let users: User
    var onDismiss: (() -> Void)? = nil
    
    var body: some View {
        VStack {
            AsyncImage(url: URL(string: users.picture.large)) { phase in
                if let image = phase.image {
                    image
                        .resizable()
                        .clipShape(.circle)
                        .frame(width: 200, height: 200)
                } else if phase.error != nil {
                    Image(systemName: "person.crop.circle")
                        .resizable()
                        .clipShape(.circle)
                        .frame(width: 200, height: 200)
                } else {
                    ProgressView()
                        .progressViewStyle(.circular)
                        .scaleEffect(2)
                        .frame(width: 200, height: 200)
                }
            }
            Text("\(users.name.first) \(users.name.last)")
                .font(.system(size: 32))
                .fontWeight(.bold)
                .padding()
            
            VStack(alignment: .leading, spacing: 3) {
                HStack {
                    Image(systemName: "envelope")
                        .frame(width: 20)
                    Text(users.email)
                }
                HStack {
                    Image(systemName: "house")
                        .frame(width: 20)
                    Text("\(users.location.street.name) \(users.location.street.number)")
                }
                HStack {
                    Image(systemName: "location")
                        .frame(width: 20)
                    Text(users.location.city)
                }
                HStack {
                    Image(systemName: "globe")
                        .frame(width: 20)
                    Text(users.location.country)
                }
                HStack {
                    Image(systemName: "phone")
                        .frame(width: 20)
                    Text(users.phone)
                }
            }
        }
        .frame(width: 320, height: 530)
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(radius: 5)
        .overlay(Button {
            onDismiss?()
        } label: {
            ZStack{
                Circle()
                    .frame(width: 30, height: 30)
                    .foregroundColor(.white)
                    .shadow(radius: 20)
                
                Image(systemName: "xmark")
                    .frame(width: 45, height: 45)
                    .foregroundColor(.black)
            }
        }, alignment: .topTrailing)
    }
}

#Preview {
    UserDetailsView(users: Mockdata.sampleUser)
}
