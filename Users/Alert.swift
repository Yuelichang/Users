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
    static let InvalidURL = AlertItem(title: Text("Server Error"),
                                      message: Text("URL not found."),
                                      dismissButton: .default(Text("OK")))
    
    static let InvalidResponse = AlertItem(title: Text("Server Error"),
                                      message: Text("Invalid response from the server."),
                                      dismissButton: .default(Text("OK")))
    
    static let InvalidData = AlertItem(title: Text("Server Error"),
                                      message: Text("Data received from server was invalid."),
                                      dismissButton: .default(Text("OK")))
}

