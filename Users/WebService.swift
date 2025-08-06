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
        
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                throw UserErrors.InvalidResponse
            }
            let decoder = JSONDecoder()
            return try decoder.decode(UserResponse.self, from: data)
        } catch is DecodingError {
            throw UserErrors.InvalidData
        } catch is URLError {
            throw UserErrors.UnableToComplete
        } catch {
            throw UserErrors.InvalidResponse
        }
        
        
    }
}
