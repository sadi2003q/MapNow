//
//  MapNowApp.swift
//  MapNow
//
//  Created by  Sadi on 15/01/2025.
//

import SwiftUI
import SwiftData

@main
struct MapNowApp: App {
    

    var body: some Scene {
        
        WindowGroup {
            NavigationStack {
                //DestinationLocationMapView()
                DestinationListView()
            }
            
        }
        .modelContainer(for: DestinationModel.self)
    }
}
