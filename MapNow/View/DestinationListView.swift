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
    @Query(sort: \DestinationModel.name) private var destinations: [DestinationModel]
    
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
            HStack{
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
                Button {
                    withAnimation {
                                if let index = destinations.firstIndex(of: destination) {
                                    destinations.remove(at: index)  // Animate removal
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                                        modelContext.delete(destination)  // Delete after animation
                                    }
                                }
                            }
                    
                } label: {
                    Label("Delete", systemImage: "trash")
                        .tint(.red)
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
                modelContext.insert(DestinationModel(name: destinationName))
                destinationName = ""
            }
            .disabled( destinationName.isEmpty ? true : false)
            
            Button("Cancel", role: .cancel) {}
        }
    }
    
    
    
}

#Preview {
    DestinationListView()
        //.modelContainer(for: DestinationModel.self)
        .modelContainer(DestinationModel.preview)
}

