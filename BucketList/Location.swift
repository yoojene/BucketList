//
//  Location.swift
//  BucketList
//
//  Created by Eugene on 08/09/2023.
//

import Foundation


struct Location: Identifiable, Codable, Equatable {
    let id: UUID
    var name: String
    var description: String
    let latitude: Double
    let longitude: Double
}
