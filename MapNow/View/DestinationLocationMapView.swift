//
//  DestinationLocationMapView.swift
//  MapNow
//
//  Created by  Sadi on 15/01/2025.
//

import SwiftUI
import MapKit

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
    
    var body: some View {
        Map(position: $cameraPosition) {
            
            /// Marker for the **Air Force Museum** with a red circle icon.
            Marker(DhakaLocation.airForceMuseum.location.name, systemImage: "circle.fill", coordinate: DhakaLocation.airForceMuseum.location.coordinate)
            
            /// Marker for **Ahsan Manzil** with a purple tint.
            Marker(DhakaLocation.ahsanManzil.location.name, coordinate: DhakaLocation.ahsanManzil.location.coordinate)
                .tint(.purple)
            
            /// Text annotation for **Army Stadium**.
            Annotation(DhakaLocation.armyStadium.location.name, coordinate: DhakaLocation.armyStadium.location.coordinate) {
                Text("Army Stadium")
            }
            
            /// Custom pin annotation for **Curzon Hall**.
            Annotation(DhakaLocation.curzonHall.location.name, coordinate: DhakaLocation.curzonHall.location.coordinate, anchor: .center) {
                Image(systemName: "mappin")
                    .scaleEffect(2)
            }
            
            /// Circular overlay centered near Dhaka with a 5 km radius.
            MapCircle(center: CLLocationCoordinate2D(latitude: 23.8041, longitude: 90.4152), radius: 5000)
                .foregroundStyle(.red.opacity(0.2))
            
        }
        /// Updates `visibleRegion` when the map camera movement ends.
        .onMapCameraChange(frequency: .onEnd) { context in
            visibleRegion = context.region
        }
        /// Sets the initial camera position to focus on Dhaka upon view appearance.
        .onAppear {
            let currentLocation = CLLocationCoordinate2D(latitude: 23.8041, longitude: 90.4152)
            let currentLocationSpan = MKCoordinateSpan(latitudeDelta: 0.15, longitudeDelta: 0.15)
            let currentLocationRegion = MKCoordinateRegion(center: currentLocation, span: currentLocationSpan)
            
            cameraPosition = .region(currentLocationRegion)
        }
    }
}

#Preview {
    NavigationStack {
        DestinationLocationMapView()
    }
}
