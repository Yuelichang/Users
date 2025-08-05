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
                        .scaleEffect(4)
                        .frame(width: 200, height: 200)
                }
            }
            .padding(.bottom, 30)
            
            Text("\(users.name.first) \(users.name.last)")
                .font(.headline)
                .fontWeight(.bold)
                
            
            Text(users.email)
            Text("\(users.location.street.name) \(users.location.street.number)")
            Text(users.location.city)
            Text(users.location.country)
            Text(users.phone)
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
