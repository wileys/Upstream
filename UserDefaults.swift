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

var eventName: String {
    get {
        return UserDefaults.standard.string(forKey: "eventName")!
    }
    set {
        UserDefaults.standard.string(forKey: "eventName")
    }
    
}






