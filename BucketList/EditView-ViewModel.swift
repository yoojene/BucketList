//
//  EditView-ViewModel.swift
//  BucketList
//
//  Created by Eugene on 10/09/2023.
//

import Foundation

extension EditView {
   
    @MainActor class ViewModel: ObservableObject {
       
       @Published var name: String
       @Published var description: String
       @Published var pages = [Page]()
       
       init(location: Location) {
           
           _name = Published(initialValue: location.name)
           _description = Published(initialValue: location.description)
       }
    }
}
