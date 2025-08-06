//
//  Gender.swift
//  Users
//
//  Created by Yü Li Chang on 06.08.25.
//

import Foundation

enum Gender: String, CaseIterable, Identifiable, Decodable {
    case all = "all"
    case female = "female"
    case male = "male"
    case other = "other"
    
    var id: Self {self}
}
