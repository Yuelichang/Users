//
//  Alert.swift
//  Users
//
//  Created by Yü Li Chang on 05.08.25.
//

import SwiftUI

struct AlertItem: Identifiable {
    let id = UUID()
    let title: Text
    let message: Text
    let dismissButton: Alert.Button
}


struct AlertContext {
    static let InvalidURLTitle = Text("Server Error")
    static let InvalidURLMessage = Text("URL not found.")
    
    static let InvalidResponseTitle = Text("Server Error")
    static let InvalidResponseMessage = Text("Invalid response from the server.")
    
    static let InvalidDataTitle = Text("Server Error")
    static let InvalidDataMessage = Text("Data received from server was invalid.")
    
    static let UnableToCompleteTitle = Text("Network Error")
    static let UnableToCompleteMessage = Text("Unable to complete your request. Please check your internet connection.")
}

