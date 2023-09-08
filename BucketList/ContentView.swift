//
//  ContentView.swift
//  BucketList
//
//  Created by Eugene on 08/09/2023.
//

import LocalAuthentication
import SwiftUI

struct ContentView: View {
    
    @State private var isUnlocked = false
    
    var body: some View {
        VStack {
            if isUnlocked {
                Text("unlocked!")
            } else {
                Text("locked")
            }
        }
        .onAppear(perform: authenticate)
    }
    
    func authenticate() {
        
        let context = LAContext()
        
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            
            let reason = "We need to unlock your data" // FaceID reason
            
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
                if success {
                    isUnlocked = true
                } else {
                    // there was a prob
                }
            }
            
        } else {
            // no biometrics
        }
        
    }
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
