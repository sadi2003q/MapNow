//
//  DestinationLocationMapView.swift
//  MapNow
//
//  Created by  Sadi on 15/01/2025.
//

import SwiftUI
import MapKit
import SwiftData

/// A SwiftUI view that displays a map with various markers and annotations highlighting notable locations in Dhaka.
///
/// `DestinationLocationMapView` uses Apple's `MapKit` to present a map with markers, annotations, and a circle overlay.
/// On appearance, the map focuses on a specific region of Dhaka, and updates the visible region when the camera position changes.
///
/// This view includes:
/// - Markers for popular landmarks in Dhaka.
/// - Custom annotations for specific locations.
/// - A `MapCircle` overlay to highlight a region.
/// - Dynamic camera movement handling.
///
/// ### Usage
/// ```swift
/// NavigationStack {
///     DestinationLocationMapView()
/// }
/// ```
///
/// ### Features
/// - Zoom and pan interactions with automatic camera positioning.
/// - Custom markers and annotations.
/// - Visual region tracking with `onMapCameraChange`.
/// ### Usage
/// ```swift
///  Map(coordinateRegion: $region)
///    .onMapCameraChange { context in
///        let center = context.region.center
///        print("Map Center: Latitude: \(center.latitude), Longitude: \(center.longitude)")
///    }
/// }
/// ```
/// - Tracks any camera movement (panning or zooming).
/// - Prints the new center coordinate of the map.
///
/// ### Example Locations
/// - **Air Force Museum**: Marked with a red circle icon.
/// - **Ahsan Manzil**: Marked with a purple marker.
/// - **Army Stadium**: Annotated with text.
/// - **Curzon Hall**: Annotated with a larger map pin icon.
///
/// ### Dependencies
/// - SwiftUI
/// - MapKit
///
/// ### Author
/// - Created by Sadi on 15/01/2025.
///
struct DestinationLocationMapView: View {
    
    /// The current camera position of the map, initialized to `.automatic`.
    @State private var cameraPosition: MapCameraPosition = .automatic
    
    /// The visible region of the map, updated when the camera position changes.
    @State private var visibleRegion: MKCoordinateRegion?
    
    @Query private var destinations: [DestinationModel]
    
    @State private var destination: DestinationModel?
    
    var body: some View {
        Map(position: $cameraPosition) {
            
            if let destination {
                ForEach(destination.placeMarks) { placeMark in
                    Marker(coordinate: placeMark.coordinate) {
                        Label(placeMark.name, systemImage: "star")
                    }
                    .tint(.green)
                }
            }
            
        }
        /// Updates `visibleRegion` when the map camera movement ends.
        .onMapCameraChange(frequency: .onEnd) { context in
            visibleRegion = context.region
        }
        .onAppear {
            destination = destinations.first
            if let region = destination?.region {
                cameraPosition = .region(region)
            }
        }
        .ignoresSafeArea()
    }
}

#Preview {
    NavigationStack {
        DestinationLocationMapView()
            .modelContainer(DestinationModel.preview)
    }
}
