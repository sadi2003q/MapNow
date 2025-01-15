//
//  DestinationModel.swift
//  MapNow
//
//  Created by  Sadi on 15/01/2025.
//

import SwiftData
import MapKit

@Model
class DestinationModel {
    var name: String
    var latitude: Double?
    var longitude: Double?
    
    var longitudeDelta: Double?
    var latitudeDelta: Double?
    
    @Relationship(deleteRule: .cascade)
    var placeMarks: [MTPlacemark] = []
    
    
    init(name: String, latitude: Double? = nil, longitude: Double? = nil, longitudeDelta: Double? = nil, latitudeDelta: Double? = nil) {
        self.name = name
        self.latitude = latitude
        self.longitude = longitude
        self.longitudeDelta = longitudeDelta
        self.latitudeDelta = latitudeDelta
    }
    
    var region: MKCoordinateRegion? {
        guard let latitude, let longitude, let longitudeDelta, let latitudeDelta else { return nil }
        return MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: latitude, longitude: longitude),
            span: MKCoordinateSpan(latitudeDelta: latitudeDelta, longitudeDelta: longitudeDelta)
        )
    }
}

extension DestinationModel {
    @MainActor
    static var preview: ModelContainer {
        let container = try! ModelContainer(
            for: DestinationModel.self,
            configurations: ModelConfiguration(isStoredInMemoryOnly: true))
        
            let Dhaka = DestinationModel(
                name: "Dhaka",
                latitude: 23.8041,
                longitude: 90.4152,
                longitudeDelta: 0.15,
                latitudeDelta: 0.15
        
            )
        container.mainContext.insert(Dhaka)
        
        var placeMarks: [MTPlacemark] {
            [
                MTPlacemark(
                    name: "Bashundhara City",
                    address: "Panthapath, Dhaka 1215, Bangladesh",
                    latitude: 23.7509,
                    longitude: 90.3866
                ),
                MTPlacemark(
                    name: "National Parliament House",
                    address: "Sher-e-Bangla Nagar, Dhaka 1207, Bangladesh",
                    latitude: 23.7628,
                    longitude: 90.3782
                ),
                MTPlacemark(
                    name: "Bangladesh National Museum",
                    address: "Shahbagh Rd, Dhaka 1000, Bangladesh",
                    latitude: 23.7370,
                    longitude: 90.3945
                ),
                MTPlacemark(
                    name: "Lalbagh Fort",
                    address: "Lalbagh Rd, Dhaka 1211, Bangladesh",
                    latitude: 23.7196,
                    longitude: 90.3880
                ),
                MTPlacemark(
                    name: "Ahsan Manzil",
                    address: "Islampur Rd, Dhaka 1100, Bangladesh",
                    latitude: 23.7086,
                    longitude: 90.4061
                ),
                MTPlacemark(
                    name: "Dhakeshwari Temple",
                    address: "Dhakeshwari Rd, Dhaka 1203, Bangladesh",
                    latitude: 23.7190,
                    longitude: 90.3883
                ),
                MTPlacemark(
                    name: "Hatirjheel",
                    address: "Hatirjheel Lake, Dhaka, Bangladesh",
                    latitude: 23.7500,
                    longitude: 90.3960
                ),
                MTPlacemark(
                    name: "Gulshan Lake Park",
                    address: "Gulshan Ave, Dhaka 1212, Bangladesh",
                    latitude: 23.7925,
                    longitude: 90.4169
                ),
                MTPlacemark(
                    name: "Ramna Park",
                    address: "Minto Rd, Dhaka 1000, Bangladesh",
                    latitude: 23.7361,
                    longitude: 90.4005
                ),
                MTPlacemark(
                    name: "Bangabandhu Sheikh Mujib Medical University",
                    address: "Shahbagh, Dhaka 1000, Bangladesh",
                    latitude: 23.7380,
                    longitude: 90.3950
                ),
                MTPlacemark(
                    name: "Shishu Park",
                    address: "Shahbagh, Dhaka 1000, Bangladesh",
                    latitude: 23.7378,
                    longitude: 90.3965
                ),
                MTPlacemark(
                    name: "Dhaka University",
                    address: "Nilkhet Rd, Dhaka 1000, Bangladesh",
                    latitude: 23.7333,
                    longitude: 90.3925
                ),
                MTPlacemark(
                    name: "Star Mosque",
                    address: "Armanitola Rd, Dhaka 1100, Bangladesh",
                    latitude: 23.7106,
                    longitude: 90.4011
                ),
                MTPlacemark(
                    name: "Sadarghat",
                    address: "Sadarghat, Dhaka 1100, Bangladesh",
                    latitude: 23.7010,
                    longitude: 90.4113
                ),
                MTPlacemark(
                    name: "Baitul Mukarram National Mosque",
                    address: "Baitul Mukarram, Dhaka 1000, Bangladesh",
                    latitude: 23.7276,
                    longitude: 90.4110
                ),
                MTPlacemark(
                    name: "New Market",
                    address: "Mirpur Rd, Dhaka 1205, Bangladesh",
                    latitude: 23.7274,
                    longitude: 90.3845
                ),
                MTPlacemark(
                    name: "Kawran Bazar",
                    address: "Kawran Bazar, Dhaka 1215, Bangladesh",
                    latitude: 23.7510,
                    longitude: 90.3928
                ),
                MTPlacemark(
                    name: "Sher-e-Bangla National Cricket Stadium",
                    address: "Mirpur, Dhaka 1216, Bangladesh",
                    latitude: 23.8060,
                    longitude: 90.3686
                ),
                MTPlacemark(
                    name: "Mouchak Market",
                    address: "Malibagh, Dhaka, Bangladesh",
                    latitude: 23.7465,
                    longitude: 90.4125
                ),
                MTPlacemark(
                    name: "Zero Point (Noor Hossain Square)",
                    address: "Gulistan, Dhaka, Bangladesh",
                    latitude: 23.7111,
                    longitude: 90.4074
                )
            ]
        }
        
        placeMarks.forEach { placeMark in
            Dhaka.placeMarks.append(placeMark)
        }
        
        return container
    }

    
    
}
