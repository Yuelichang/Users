//
//  UsersModel.swift
//  Users
//
//  Created by Yü Li Chang on 02.08.25.
//

import Foundation

struct UserResponse: Decodable {
    let results: [User]
}

struct User: Decodable, Identifiable {
    var id: String { login.uuid }
    let name: Name
    let email: String
    let login: Login
    let picture: Picture

    struct Name: Decodable {
        let first: String
        let last: String
    }

    struct Login: Decodable {
        let uuid: String
    }
    
    struct Picture: Decodable {
        let thumbnail: String
        let medium: String
    }
}

struct Mockdata {
    static let sampleUser = User(name: User.Name(first: "Andy", last: "Lin"),
                                 email: "andi_lin@icloud.com",
                                 login: User.Login(uuid: "123"),
                                 picture: User.Picture(thumbnail: "https://static.wikia.nocookie.net/bossbaby/images/1/1d/Jimbo.png/revision/latest?cb=20220416180336", medium: "https://static.wikia.nocookie.net/bossbaby/images/1/1d/Jimbo.png/revision/latest?cb=20220416180336"))
    
    static let users = [sampleUser, sampleUser, sampleUser, sampleUser, sampleUser, sampleUser, sampleUser, sampleUser, sampleUser, sampleUser, sampleUser, sampleUser]
}
