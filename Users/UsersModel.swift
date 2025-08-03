//
//  UsersModel.swift
//  Users
//
//  Created by Yü Li Chang on 02.08.25.
//

import Foundation

struct Response: Decodable {
    let results: [User]
}

struct User: Decodable {
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
                                 picture: User.Picture(thumbnail: "https://platform.vox.com/wp-content/uploads/sites/2/chorus/uploads/chorus_asset/file/8232671/bossbabycover.jpg?quality=90&strip=all&crop=11.206896551724,0,77.586206896552,100", medium: "https://platform.vox.com/wp-content/uploads/sites/2/chorus/uploads/chorus_asset/file/8232671/bossbabycover.jpg?quality=90&strip=all&crop=11.206896551724,0,77.586206896552,100"))
    
    static let users = [sampleUser, sampleUser, sampleUser, sampleUser]
}
