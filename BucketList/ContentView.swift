//
//  ContentView.swift
//  BucketList
//
//  Created by Eugene on 08/09/2023.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        Text("Hello")
            .onTapGesture {
                let message = FileManager.default.decode("Test message to bundle", "Messagesss.txt")
                print(message)
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
