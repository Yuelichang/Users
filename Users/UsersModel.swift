//
//  UsersModel.swift
//  Users
//
//  Created by Yü Li Chang on 02.08.25.
//

import Foundation

struct UserResponse: Decodable {
    var results: [User]
}

struct User: Decodable, Identifiable {
    var id: String { login.uuid }
    let name: Name
    let email: String
    let login: Login
    let picture: Picture
    let location: Location
    let phone: String
    let gender: Gender
    
    struct Name: Decodable {
        let first: String
        let last: String
    }
    
    struct Location: Decodable {
        let street: Street
        let city: String
        let country: String
    }
    
    struct Street: Decodable {
        let name: String
        let number: Int
    }
    
    struct Login: Decodable {
        let uuid: String
    }
    
    struct Picture: Decodable {
        let thumbnail: String
        let large: String
    }
}

struct Mockdata {
    static let sampleUser = User(name: User.Name(first: "Andy", last: "Lin"),
                                 email: "andi_lin@icloud.com",
                                 login: User.Login(uuid: "123"),
                                 picture: User.Picture(thumbnail: "https://static.wikia.nocookie.net/bossbaby/images/1/1d/Jimbo.png/revision/latest?cb=20220416180336", large: "https://static.wikia.nocookie.net/bossbaby/images/1/1d/Jimbo.png/revision/latest?cb=20220416180336"),
                                 location: User.Location(
                                    street: User.Street(name: "TestStreet", number: 1),
                                    city: "Vienna",
                                    country: "Austria"),
                                 phone: "123456789",
                                 gender: Gender.male
    )
    
    static let users = [sampleUser, sampleUser, sampleUser, sampleUser, sampleUser, sampleUser, sampleUser, sampleUser, sampleUser, sampleUser, sampleUser, sampleUser]
}
