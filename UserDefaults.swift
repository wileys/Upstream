//
//  UserDefaults.swift
//  Upstream
//
//  Created by Wiley Siler on 7/12/17.
//  Copyright © 2017 Wiley Siler. All rights reserved.
//

import Foundation


var bioDiversity: Double {
    get {
        return UserDefaults.standard.double(forKey: "bioDiversity")
    }
    set {
        UserDefaults.standard.set(newValue, forKey: "bioDiversity")
    }
}


var dayCount: Int {
    get {
        return UserDefaults.standard.integer(forKey: "dayCount")
    }
    set {
        UserDefaults.standard.set(newValue, forKey: "dayCount")
    }
}


var totalSpecimens: Int {
    get {
        return UserDefaults.standard.integer(forKey: "totalSpecimens")
    }
    set {
        UserDefaults.standard.set(newValue, forKey: "totalSpecimens")
    }
}


var lionCount: Int {
    get {
        return UserDefaults.standard.integer(forKey: "lionCount")
    }
    set {
        UserDefaults.standard.set(newValue, forKey: "lionCount")
    }
    
}
var giraffeCount: Int {
    get {
        return UserDefaults.standard.integer(forKey: "giraffeCount")
    }
    set {
        UserDefaults.standard.set(newValue, forKey: "giraffeCount")
    }
    
}
var goldenCount: Int  {
    get {
        return UserDefaults.standard.integer(forKey: "goldenCount")
    }
    set {
        UserDefaults.standard.set(newValue, forKey: "goldenCount")
    }
    
}
var sealCount: Int {
    get {
        return UserDefaults.standard.integer(forKey: "sealCount")
    }
    set {
        UserDefaults.standard.set(newValue, forKey: "sealCount")
    }
    
}

var chickenCount: Int {
    get {
        return UserDefaults.standard.integer(forKey: "chickenCount")
    }
    set {
        UserDefaults.standard.set(newValue, forKey: "chickenCount")
    }
    
}

var spiderCount: Int {
    get {
        return UserDefaults.standard.integer(forKey: "spiderCount")
    }
    set {
        UserDefaults.standard.set(newValue, forKey: "spiderCount")
    }
    
}

var caterpillarCount: Int {
    get {
        return UserDefaults.standard.integer(forKey: "caterpillarCount")
    }
    set {
        UserDefaults.standard.set(newValue, forKey: "caterpillarCount")
    }
    
}

var penguinCount: Int {
    get {
        return UserDefaults.standard.integer(forKey: "penguinCount")
    }
    set {
        UserDefaults.standard.set(newValue, forKey: "penguinCount")
    }
    
}

var monkeyCount: Int {
    get {
        return UserDefaults.standard.integer(forKey: "monkeyCount")
    }
    set {
        UserDefaults.standard.set(newValue, forKey: "monkeyCount")
    }
    
}

var eagleCount: Int {
    get {
        return UserDefaults.standard.integer(forKey: "eagleCount")
    }
    set {
        UserDefaults.standard.set(newValue, forKey: "eagleCount")
    }
    
}

var pandaCount: Int {
    get {
        return UserDefaults.standard.integer(forKey: "pandaCount")
    }
    set {
        UserDefaults.standard.set(newValue, forKey: "pandaCount")
    }
    
}

var foxCount: Int {
    get {
        return UserDefaults.standard.integer(forKey: "foxCount")
    }
    set {
        UserDefaults.standard.set(newValue, forKey: "foxCount")
    }
    
}

var butterflyCount: Int {
    get {
        return UserDefaults.standard.integer(forKey: "butterflyCount")
    }
    set {
        UserDefaults.standard.set(newValue, forKey: "butterflyCount")
    }
    
}

var snakeCount: Int {
    get {
        return UserDefaults.standard.integer(forKey: "snakeCount")
    }
    set {
        UserDefaults.standard.set(newValue, forKey: "snakeCount")
    }
    
}

var sharkCount: Int {
    get {
        return UserDefaults.standard.integer(forKey: "sharkCount")
    }
    set {
        UserDefaults.standard.set(newValue, forKey: "sharkCount")
    }
    
}

var rabbitCount: Int {
    get {
        return UserDefaults.standard.integer(forKey: "rabbitCount")
    }
    set {
        UserDefaults.standard.set(newValue, forKey: "rabbitCount")
    }
    
}

var octopusCount: Int {
    get {
        return UserDefaults.standard.integer(forKey: "octopusCount")
    }
    set {
        UserDefaults.standard.set(newValue, forKey: "octopusCount")
    }
    
}

var cowCount: Int {
    get {
        return UserDefaults.standard.integer(forKey: "cowCount")
    }
    set {
        UserDefaults.standard.set(newValue, forKey: "cowCount")
    }
    
}

var eventName: String {
    get {
        return UserDefaults.standard.string(forKey: "eventName")!
    }
    set {
        UserDefaults.standard.string(forKey: "eventName")
    }
    
}

var previousBioNumber: Double {
    get {
        return UserDefaults.standard.double(forKey: "previousBioNumber")
    }
    set {
        UserDefaults.standard.set(newValue, forKey: "previousBioNumber")
    }
    
}


var hasDoneHeatEvent: Bool {
    get {
        return UserDefaults.standard.bool(forKey: "hasDoneHeatEvent")
    }
    set {
        UserDefaults.standard.set(newValue, forKey: "hasDoneHeatEvent")
    }
    
}

var hasDoneHeroEvent: Bool {
    get {
        return UserDefaults.standard.bool(forKey: "hasDoneHeroEvent")
    }
    set {
        UserDefaults.standard.set(newValue, forKey: "hasDoneHeroEvent")
    }
    
}

var hasDoneChemicalEvent: Bool {
    get {
        return UserDefaults.standard.bool(forKey: "hasDoneChemicalEvent")
    }
    set {
        UserDefaults.standard.set(newValue, forKey: "hasDoneChemicalEvent")
    }
    
}

var hasDoneWindEvent: Bool {
    get {
        return UserDefaults.standard.bool(forKey: "hasDoneWindEvent")
    }
    set {
        UserDefaults.standard.set(newValue, forKey: "hasDoneWindEvent")
    }
    
}

var hasDoneDroughtEvent: Bool {
    get {
        return UserDefaults.standard.bool(forKey: "hasDoneDroughtEvent")
    }
    set {
        UserDefaults.standard.set(newValue, forKey: "hasDoneDroughtEvent")
    }
    
}

var hasDoneWeatherEvent: Bool {
    get {
        return UserDefaults.standard.bool(forKey: "hasDoneWeatherEvent")
    }
    set {
        UserDefaults.standard.set(newValue, forKey: "hasDoneWeatherEvent")
    }
    
}


var hasDoneGiraffeEvent: Bool {
    get {
        return UserDefaults.standard.bool(forKey: "hasDoneGiraffeEvent")
    }
    set {
        UserDefaults.standard.set(newValue, forKey: "hasDoneGiraffeEvent")
    }
    
}

var hasDoneTutorialEvent: Bool {
    get {
        return UserDefaults.standard.bool(forKey: "hasDoneTutorialEvent")
    }
    set {
        UserDefaults.standard.set(newValue, forKey: "hasDoneTutorialEvent")
    }
    
}

var hasDoneSpiderEvent: Bool {
    get {
        return UserDefaults.standard.bool(forKey: "hasDoneSpiderEvent")
    }
    set {
        UserDefaults.standard.set(newValue, forKey: "hasDoneSpiderEvent")
    }
    
}


var hasWonGame: Bool {
    get {
        return UserDefaults.standard.bool(forKey: "hasWonGame")
    }
    set {
        UserDefaults.standard.set(newValue, forKey: "hasWonGame")
    }
}



