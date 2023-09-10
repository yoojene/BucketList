//
//  ContentView-ViewModel.swift
//  BucketList
//
//  Created by Eugene on 10/09/2023.
//

import Foundation
import LocalAuthentication
import MapKit

extension ContentView {
    // @MainActor means will update UI - all ObervableObject classes should be marked as such
    @MainActor class ViewModel: ObservableObject {
        
        // these will all be listened for in ContentView
        @Published var mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 50, longitude: 0),span: MKCoordinateSpan(latitudeDelta: 25, longitudeDelta: 25))
        @Published private(set) var locations: [Location]
        @Published var selectedPlace: Location?
        @Published var isUnlocked = false
        @Published var hasError = false
        @Published var errorMessage = ""
        
        let savePath = FileManager.documentsDirectory.appendingPathComponent("SavedPlaces")
        
        // try to load the locations saved in documents directory, else return empty []
        init() {
            do {
                let data = try Data(contentsOf: savePath)
                locations = try JSONDecoder().decode([Location].self, from: data)
            } catch {
                locations = []
            }
        }
        
        func save() {
            do {
                let data = try JSONEncoder().encode(locations)
                // encrypt data when writing with .completeFileProtection
                try data.write(to: savePath, options: [.atomicWrite, .completeFileProtection])
            } catch {
                print("Unable to save data!")
            }
        }
        
        func addLocation() {
            let newLocation = Location(id: UUID(), name: "New location", description: "", latitude: mapRegion.center.latitude, longitude: mapRegion.center.longitude)
            locations.append(newLocation)
            save()
        }
        
        func update(location: Location) {
            guard let selectedPlace = selectedPlace else { return }
            
            if let index = locations.firstIndex(of: selectedPlace) {
                locations[index] = location
                save()
            }
        }
        
        func authenticate() {
            
            let context = LAContext()
            var error: NSError?
            
            if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
                let reason = "Please authenticate yourself to unlock your places"
                
                // Apple runs this auth policy check anywhere, not necessarily main actor
                context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
                    if success {
                        Task { @MainActor in // this makes the whole background task run on the Main Actor.  Stop runtime error warning
                            self.isUnlocked = true
                        }
                    } else {
                        // error
                        Task { @MainActor in // this makes the whole background task run on the Main Actor.  Stop runtime error warning
                            self.errorMessage = authenticationError!.localizedDescription
                            self.hasError = true
                        }
 
                        
                    }
                }
            } else {
                // no biometrics on device
                Task { @MainActor in // this makes the whole background task run on the Main Actor.  Stop runtime error warning
                    self.errorMessage = error!.localizedDescription
                    self.hasError = true
                }
            }
            
        }
        
    }
}

