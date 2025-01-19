//
//  MapManagement.swift
//  MapNow
//
//  Created by  Sadi on 19/01/2025.
//

import Foundation
import SwiftData
import MapKit

enum MapManagement {
    
    @MainActor
    static func searchPlaces(_ modelContext: ModelContext, searchText: String, visibleRegion: MKCoordinateRegion?) async {
        
        removeSearchResults(from: modelContext)
        
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = searchText
        
        if let visibleRegion {
            request.region = visibleRegion
        }
        
        let searchItem = try? await MKLocalSearch(request: request).start()
        
        let result = searchItem?.mapItems ?? []
        
        result.forEach {
            let mtPlaceMark = MTPlacemark(
                name: $0.name ?? "",
                address: $0.name ?? "",
                latitude: $0.placemark.coordinate.latitude,
                longitude: $0.placemark.coordinate.longitude
            )
            modelContext.insert(mtPlaceMark)
        }
    }
    
    
    static func removeSearchResults(from modelContext:ModelContext) {
        let searchPredicate = #Predicate<MTPlacemark> { $0.destination == nil }
        try? modelContext.delete(model: MTPlacemark.self, where: searchPredicate)
    }
}
