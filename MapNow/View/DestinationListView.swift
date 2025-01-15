//
//  DestinationListView.swift
//  MapNow
//
//  Created by  Sadi on 15/01/2025.
//

import SwiftUI
import SwiftData

struct DestinationListView: View {
    
    @Query(sort: \DestinationModel.name) private var destinations: [DestinationModel]
    
    var body: some View {
        if !destinations.isEmpty {
            
        }  else {
            ContentUnavailableView("No Destination Found",
                                   systemImage: "globe.desk",
                                   description: Text("You Have not setup any locations yet. Tap on \(Image(systemName: "plus.circle.fill")) button in the toolbar to begin."))
        }
        
    }
}

#Preview {
    DestinationListView()
        .modelContainer(for: DestinationModel.self)
}
