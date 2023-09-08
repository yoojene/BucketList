//
//  Filemanager-Decodable.swift
//  BucketList
//
//  Created by Eugene on 08/09/2023.
//

import Foundation

extension FileManager {
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask) // sandboxed directory for the app
        return paths[0]
    }
    
    func decode(_ message: String, _ fileName: String) -> String {
        
        let str = message
        let url = getDocumentsDirectory().appendingPathComponent(fileName)
        
        do {
            try str.write(to: url, atomically: true, encoding: .utf8)
            
            let input = try String(contentsOf: url)

            return input
        } catch {
            print(error.localizedDescription)
        }
        
        return ""
        
    }
}
