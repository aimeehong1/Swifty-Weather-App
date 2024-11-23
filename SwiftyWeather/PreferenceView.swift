//
//  PreferenceView.swift
//  SwiftyWeather
//
//  Created by Aimee Hong on 11/18/24.
//

import SwiftUI
import SwiftData

struct PreferenceView: View {
    @Query var preferences: [Preference]
    @State private var locationName = ""
    @State private var longString = ""
    @State private var latString = ""
    @State private var selectedUnit: UnitSystem = .imperial
    @State private var degreeUnitShowing = true
    var degreeUnit: String {
        if degreeUnitShowing {
            return selectedUnit == .imperial ? "F" : "C"
        }
        return ""
    }
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                TextField("location", text: $locationName)
                    .font(.title)
                    .textFieldStyle(.roundedBorder)
                    .padding(.bottom)
                
                Group {
                    Text("Latitude")
                        .bold()
                    
                    TextField("latitude", text: $latString)
                    
                    Text("Longitude")
                        .bold()
                    
                    TextField("longitude", text: $longString)
                        .padding(.bottom)
                }
                .font(.title2)
                
                HStack {
                    Text("Units")
                        .bold()
                    
                    Spacer()
                    
                    Picker("", selection: $selectedUnit) {
                        ForEach(UnitSystem.allCases, id: \.self) { unitCase in
                            Text(unitCase.rawValue)
                        }
                    }
                }
                .font(.title2)
                
                Toggle("Show F/C after temp value:", isOn: $degreeUnitShowing)
                    .font(.title2)
                    .bold()
                
                HStack {
                    Spacer()
                    Text("42°\(degreeUnit)")
                        .font(.system(size: 150))
                        .fontWeight(.thin)
                    Spacer()
                }
                
                Spacer()
            }
            .padding()
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Save") {
                        if !preferences.isEmpty {
                            for preference in preferences {
                                modelContext.delete(preference)
                            }
                        }
                        let preference = Preference(
                            locationName: locationName,
                            latString: latString,
                            longString: longString,
                            selectedUnit: selectedUnit,
                            degreeUnitShowing: degreeUnitShowing
                        )
                        modelContext.insert(preference)
                        guard let _ = try? modelContext.save() else {
                            print("😡 ERROR: save on PreferenceView failed.")
                            return
                        }
                        dismiss()
                    }
                }
            }
        }
        .task {
            guard !preferences.isEmpty else { return }
            let preference = preferences.first!
            locationName = preference.locationName
            longString = preference.longString
            latString = preference.latString
            selectedUnit = preference.selectedUnit
            degreeUnitShowing = preference.degreeUnitShowing
        }
    }
}

#Preview {
    NavigationStack {
        PreferenceView()
            .modelContainer(Preference.preview)
    }
}
