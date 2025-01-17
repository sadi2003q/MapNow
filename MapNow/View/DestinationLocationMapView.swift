//
//  DestinationLocationMapView.swift
//  MapNow
//
//  Created by  Sadi on 15/01/2025.
//

import SwiftUI
import MapKit
import SwiftData


struct DestinationLocationMapView: View {
    
    @Environment(\.modelContext) var modelContext
    
    @State private var cameraPosition: MapCameraPosition = .automatic
    
    @State private var visibleRegion: MKCoordinateRegion?
    
    
    @Bindable var destination: DestinationModel
    
    var body: some View {
        
        
        VStack {
            View_NewDestination
            View_AddNewLocation
            View_Map
                .ignoresSafeArea()
                .navigationTitle("Destination")
                .navigationBarTitleDisplayMode(.inline)
            
        }
        
    }
    
    private var View_Map: some View {
        Map(position: $cameraPosition) {
            ForEach(destination.placeMarks) { placeMark in
                Marker(coordinate: placeMark.coordinate) {
                    Label(placeMark.name, systemImage: "star")
                }
                .tint(.green)
            }
        }
        .onMapCameraChange(frequency: .onEnd) { context in
            visibleRegion = context.region
        }
        .onAppear {
            if let region = destination.region {
                cameraPosition = .region(region)
            }
        }
    }
    
    private var View_NewDestination: some View {
        LabeledContent {
            TextField("Enter Destination Name", text: $destination.name)
                .textFieldStyle(.roundedBorder)
                .foregroundStyle(.primary)
        } label: {
            Text("Name : ")
                .fontWeight(.bold)
        }
        .padding(.horizontal)
    }
    
    private var View_AddNewLocation: some View {
        HStack {
            Text("Adjust the map to set region for your destination.")
            Spacer()
            Button("Set Region") {
                if let visibleRegion {
                    destination.latitude = visibleRegion.center.latitude
                    destination.longitude = visibleRegion.center.longitude
                    destination.latitudeDelta = visibleRegion.span.latitudeDelta
                    destination.longitudeDelta = visibleRegion.span.longitudeDelta
                }
                try? modelContext.save()
                
            }
            .buttonStyle(.borderedProminent)
        }
        .padding(.horizontal)
    }
}

#Preview {
    let destination =  DestinationModel(
        name: "Dhaka",
        latitude: 23.8041,
        longitude: 90.4152,
        longitudeDelta: 0.15,
        latitudeDelta: 0.15
    )
    return NavigationStack {
        DestinationLocationMapView(destination: destination)
    }
}
