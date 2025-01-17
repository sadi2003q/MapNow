//
//  MapeManagement.swift
//  MapNow
//
//  Created by  Sadi on 17/01/2025.
//

import MapKit
import SwiftData

enum MapeManagement {
    @MainActor
    static func searchPlaces(_ modelContext: ModelContext, searchText: String, visibleRegion: MKCoordinateRegion?) async {
        
        removeSearchResult(from: modelContext)
        
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = searchText
        if let visibleRegion {
            request.region = visibleRegion
        }
        
        let searchItem = try? await MKLocalSearch(request: request).start()
        let results = searchItem?.mapItems ?? []
        
        results.forEach {
            let mtPlaceMark = MTPlacemark(
                name: $0.name ?? "",
                address: $0.placemark.title ?? "",
                latitude: $0.placemark.coordinate.latitude,
                longitude: $0.placemark.coordinate.longitude
            )
            modelContext.insert(mtPlaceMark)
        }
        
    }
    
    static func removeSearchResult(from modelContext: ModelContext) {
        let searchPredicate = #Predicate<MTPlacemark>{ $0.destination == nil }
        try? modelContext.delete(model: MTPlacemark.self, where: searchPredicate)
    }
}
