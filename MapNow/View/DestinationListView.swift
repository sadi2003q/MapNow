//
//  DestinationListView.swift
//  MapNow
//
//  Created by  Sadi on 15/01/2025.
//

import SwiftUI
import SwiftData

struct DestinationListView: View {
    
    @Environment(\.modelContext) var modelContext
    @Query(sort: \DestinationModel.name) private var destinationsList: [DestinationModel]
    
    @State private var destinations: [DestinationModel] = []
    
    @State private var showAlert: Bool = false
    @State private var destinationName: String = ""
    
    var body: some View {
        NavigationStack {
            DestinationListView
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button_AddView
                    }
                }
                .navigationTitle("Destination's")
            
        }
        .onAppear {
            destinations = destinationsList
        }
        
        
    }
    
    
    private var DestinationListView: some View {
        Group {
            if !destinations.isEmpty {
                View_DestinationListIsNotEmpty
            }  else {
                View_DestinationListEmpty
            }
        }
        
    }
    
    private var View_DestinationListEmpty: some View {
        
        ContentUnavailableView("No Destination Found",
                               systemImage: "globe.desk",
                               description: Text("You Have not setup any locations yet. Tap on \(Image(systemName: "plus.circle.fill")) button in the toolbar to begin."))
    }
    
    private var View_DestinationListIsNotEmpty: some View {

        List(destinations) { destination in
            NavigationLink {
                DestinationLocationMapView(destination: destination)
            } label: {
                HStack {
                    Image(systemName: "globe")
                        .font(.largeTitle)
                        .fontWeight(.semibold)
                    VStack(alignment: .leading) {
                        Text(destination.name)
                            .font(.title2)
                            .fontWeight(.semibold)
                        Text("\(destination.placeMarks.count) places to visit")
                            .foregroundColor(.secondary)
                    }
                }
                .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                    Button(role: .destructive) {
                        if let index = destinations.firstIndex(of: destination) {
                            destinations.remove(at: index)
                        }
                        modelContext.delete(destination)
                    } label: {
                        Label("Delete", systemImage: "trash")
                            .tint(.red)
                    }
                    
                }
            }

                
            
                
                
            
           
        }

    }
    
    private var Button_AddView: some View {
        Button {
            showAlert.toggle()
        } label: {
            Image(systemName: "plus.circle.fill")
                .foregroundStyle(.purple)
        }
        .alert("New Location", isPresented: $showAlert) {
            AlertView_AddingNewLocation
        } message: {
            Text("Adding new Location where new region will be added under the hood")
        }


    }
    
    private var AlertView_AddingNewLocation: some View {
        Group {
            TextField("Name", text: $destinationName)
            Button("Add", role: .none) {
                
                Add_NewDestination()
                destinationName = ""
                
            }
            .disabled( destinationName.isEmpty ? true : false)
            
            Button("Cancel", role: .cancel) {}
        }
    }
    
    private func Add_NewDestination() {
        withAnimation {
            destinations.append(DestinationModel(name: destinationName))
            modelContext.insert(DestinationModel(name: destinationName))
        }
        
    }
    
    private func deleteDestination(at offsets: IndexSet) {
        withAnimation {
            destinations.remove(atOffsets: offsets)
        }
    }
    
    
    
    
}

#Preview {
    NavigationStack {
        DestinationListView()
            .modelContainer(for: DestinationModel.self)
    }
   
}

