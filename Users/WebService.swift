//
//  WebService.swift
//  Users
//
//  Created by Yü Li Chang on 04.08.25.
//

import Foundation

final class WebService {
    
    static let baseUrl: String = "https://randomuser.me/api/"
    static let usersUrl: String = baseUrl + "?results=20"
    
    static func getUsers() async throws -> UserResponse {
        guard let url = URL(string: usersUrl) else {
            throw UserErrors.InvalidURL
        }
        
            let (data, response) = try await URLSession.shared.data(from: url)
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                throw UserErrors.InvalidResponse
            }
            
            do {
                let decoder = JSONDecoder()
                return try decoder.decode(UserResponse.self, from: data)
            }catch {
                throw UserErrors.InvalidData
            }
        
        
    }
}
