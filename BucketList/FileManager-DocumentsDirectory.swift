//
//  FileManager-DocumentsDirectory.swift
//  BucketList
//
//  Created by Eugene on 10/09/2023.
//

import Foundation

extension FileManager {
    static var documentsDirectory: URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}
