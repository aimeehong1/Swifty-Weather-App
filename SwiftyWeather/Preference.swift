//
//  Preference.swift
//  SwiftyWeather
//
//  Created by Aimee Hong on 11/18/24.
//

import Foundation
import SwiftData

@Model
@MainActor
class Preference {
    var locationName: String = ""
    var latString: String = ""
    var longString: String = ""
    var selectedUnit = UnitSystem.imperial
    var degreeUnitShowing: Bool = true
    
    init(locationName: String = "", latString: String = "", longString: String = "", selectedUnit: UnitSystem = .imperial, degreeUnitShowing: Bool = true) {
        self.locationName = locationName
        self.latString = latString
        self.longString = longString
        self.selectedUnit = selectedUnit
        self.degreeUnitShowing = degreeUnitShowing
    }
}

extension Preference {
    static var preview: ModelContainer {
        let container = try! ModelContainer(for: Preference.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))
        container.mainContext.insert(Preference(locationName: "Chestnut Hill", latString: "42.33467", longString: "-71.17007", selectedUnit: .imperial, degreeUnitShowing: true))
        
        return container
    }
}
