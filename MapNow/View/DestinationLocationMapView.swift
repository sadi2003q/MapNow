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
    
    @State private var searchText = ""
    
    @FocusState private var isSearchFocused : Bool
    @Query(filter: #Predicate<MTPlacemark> {$0.destination == nil}) private var searchPlaceMark: [MTPlacemark]
    
    private var listPlaceMark : [MTPlacemark] {
        searchPlaceMark + destination.placeMarks
    }
    
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
            ForEach(listPlaceMark) { placeMark in
                
                if placeMark.destination != nil {
                    Marker(coordinate: placeMark.coordinate) {
                        Label(placeMark.name, systemImage: "star")
                    }
                    .tint(.green)
                } else {
                    Marker(placeMark.name, coordinate: placeMark.coordinate)
                }
            }
        }
        .safeAreaInset(edge: .bottom) {
            
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
    
    private var View_SearchLocation: some View {
        HStack {
            TextField("Search ...", text: $searchText)
                .textFieldStyle(.roundedBorder)
                .focused($isSearchFocused)
                .overlay(alignment: .trailing) {
                    Button {
                        searchText = ""
                        isSearchFocused.toggle()
                    } label: {
                        Image(systemName: "magnifyingglass.circle.fill")
                            .tint(.purple)
                    }
                }
                .onSubmit {
                    Task {
                        await MapeManagement.searchPlaces(
                            modelContext,
                            searchText: searchText,
                            visibleRegion: visibleRegion
                        )
                        searchText = ""
                    }
                }
        }
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
    .modelContainer(for: DestinationModel.self)
}
