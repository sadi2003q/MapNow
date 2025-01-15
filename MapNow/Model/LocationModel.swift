//
//  LocationModel.swift
//  MapNow
//
//  Created by  Sadi on 15/01/2025.
//

import Foundation
import CoreLocation

/// A data model that represents a specific geographical location with a unique identifier, name, and coordinates.
///
/// `LocationModel` conforms to the `Identifiable` protocol, making it suitable for use in SwiftUI views that require unique identifiers for each item.
///
/// ### Properties
/// - `id`: A unique identifier generated using `UUID()`.
/// - `name`: The name of the location.
/// - `coordinate`: The geographical coordinates (`latitude` and `longitude`) of the location.
///
/// ### Usage
/// ```swift
/// let lalbaghFort = LocationModel(name: "Lalbagh Fort", coordinate: CLLocationCoordinate2D(latitude: 23.9225, longitude: 90.3889))
/// print(lalbaghFort.name)  // Output: Lalbagh Fort
/// ```
struct LocationModel: Identifiable {
    /// A unique identifier for the location.
    let id: String = UUID().uuidString
    
    /// The name of the location.
    let name: String
    
    /// The geographical coordinates of the location.
    let coordinate: CLLocationCoordinate2D
}

/// An enumeration of notable locations in Dhaka, providing predefined `LocationModel` instances for each place.
///
/// `DhakaLocation` conforms to `CaseIterable`, allowing iteration over all locations.
///
/// ### Example Usage
/// ```swift
/// let curzonHallLocation = DhakaLocation.curzonHall.location
/// print(curzonHallLocation.name)  // Output: Curzon Hall
/// ```
///
/// ### Included Locations
/// - Lalbagh Fort
/// - Ahsan Manzil
/// - National Museum
/// - Jatiyo Sangsad Bhaban
/// - Ramna Park
/// - Bangabandhu Sheikh Mujib Safari Park
/// - Curzon Hall
/// - Dhakeshwari Temple
/// - Shahid Minar
/// - Hatirjheel
/// - National Zoo
/// - Baldha Garden
/// - Gulshan Lake Park
/// - Liberation War Museum
/// - Bangladesh Air Force Museum
/// - Nandan Park
/// - Sonargaon Folk Art Museum
/// - Bangabandhu National Stadium
/// - Science Museum
/// - Army Stadium
enum DhakaLocation: CaseIterable {
    
    case lalbaghFort
    case ahsanManzil
    case nationalMuseum
    case jatiyoSangsadBhaban
    case ramnaPark
    case safariPark
    case curzonHall
    case dhakeshwariTemple
    case shahidMinar
    case hatirjheel
    case nationalZoo
    case baldhaGarden
    case gulshanLakePark
    case liberationWarMuseum
    case airForceMuseum
    case nandanPark
    case sonargaonMuseum
    case bangabandhuStadium
    case scienceMuseum
    case armyStadium

    /// Returns a `LocationModel` with the name and coordinates for each location.
    var location: LocationModel {
        switch self {
        case .lalbaghFort:
            return LocationModel(name: "Lalbagh Fort", coordinate: CLLocationCoordinate2D(latitude: 23.9225, longitude: 90.3889))
        case .ahsanManzil:
            return LocationModel(name: "Ahsan Manzil", coordinate: CLLocationCoordinate2D(latitude: 23.7086, longitude: 90.4070))
        case .nationalMuseum:
            return LocationModel(name: "National Museum", coordinate: CLLocationCoordinate2D(latitude: 23.7384, longitude: 90.3949))
        case .jatiyoSangsadBhaban:
            return LocationModel(name: "Jatiyo Sangsad Bhaban", coordinate: CLLocationCoordinate2D(latitude: 23.7615, longitude: 90.3730))
        case .ramnaPark:
            return LocationModel(name: "Ramna Park", coordinate: CLLocationCoordinate2D(latitude: 23.7389, longitude: 90.4011))
        case .safariPark:
            return LocationModel(name: "Bangabandhu Sheikh Mujib Safari Park", coordinate: CLLocationCoordinate2D(latitude: 23.9115, longitude: 90.3065))
        case .curzonHall:
            return LocationModel(name: "Curzon Hall", coordinate: CLLocationCoordinate2D(latitude: 23.7293, longitude: 90.3994))
        case .dhakeshwariTemple:
            return LocationModel(name: "Dhakeshwari Temple", coordinate: CLLocationCoordinate2D(latitude: 23.7206, longitude: 90.3889))
        case .shahidMinar:
            return LocationModel(name: "Shahid Minar", coordinate: CLLocationCoordinate2D(latitude: 23.7276, longitude: 90.3984))
        case .hatirjheel:
            return LocationModel(name: "Hatirjheel", coordinate: CLLocationCoordinate2D(latitude: 23.7579, longitude: 90.4103))
        case .nationalZoo:
            return LocationModel(name: "National Zoo", coordinate: CLLocationCoordinate2D(latitude: 23.8120, longitude: 90.3440))
        case .baldhaGarden:
            return LocationModel(name: "Baldha Garden", coordinate: CLLocationCoordinate2D(latitude: 23.7187, longitude: 90.4190))
        case .gulshanLakePark:
            return LocationModel(name: "Gulshan Lake Park", coordinate: CLLocationCoordinate2D(latitude: 23.7912, longitude: 90.4137))
        case .liberationWarMuseum:
            return LocationModel(name: "Liberation War Museum", coordinate: CLLocationCoordinate2D(latitude: 23.7596, longitude: 90.3782))
        case .airForceMuseum:
            return LocationModel(name: "Bangladesh Air Force Museum", coordinate: CLLocationCoordinate2D(latitude: 23.7786, longitude: 90.4002))
        case .nandanPark:
            return LocationModel(name: "Nandan Park", coordinate: CLLocationCoordinate2D(latitude: 23.9205, longitude: 90.2621))
        case .sonargaonMuseum:
            return LocationModel(name: "Sonargaon Folk Art Museum", coordinate: CLLocationCoordinate2D(latitude: 23.6450, longitude: 90.5980))
        case .bangabandhuStadium:
            return LocationModel(name: "Bangabandhu National Stadium", coordinate: CLLocationCoordinate2D(latitude: 23.7221, longitude: 90.4125))
        case .scienceMuseum:
            return LocationModel(name: "Science Museum", coordinate: CLLocationCoordinate2D(latitude: 23.7785, longitude: 90.3953))
        case .armyStadium:
            return LocationModel(name: "Army Stadium", coordinate: CLLocationCoordinate2D(latitude: 23.7761, longitude: 90.4139))
        }
    }
}
