//
//  Planet.swift
//  Project_1_Starunska_Aliona
//
//  Created by Aliona Starunska on 18.01.2021.
//

import UIKit

class Planet {
    
    enum Kind: String, RandomizableEnum {
        case gasGiant = "Gas Giant"
        case superEarth = "Super Earth"
        case neptunian = "Neptunian"
        case terrestrial = "Terrestrial"
    }
    
    private(set) var name: String
    private(set) var type: Kind
    private(set) var weight: Int
    private(set) var temperature: Int
    private(set) var radius: Int
    private(set) var satelites: [Planet]
    
    init(name: String = .randomPlanetName,
         type: Planet.Kind = .random,
         weight: Int = .random,
         temperature: Int = .random,
         radius: Int = .random,
         satelites: [Planet] = []) {
        self.name = name
        self.type = type
        self.weight = weight
        self.temperature = temperature
        self.radius = radius
        self.satelites = satelites
    }
}

extension Planet.Kind {
    var image: UIImage {
        switch self {
        case .gasGiant: return Assets.Planets.gasGiant
        case .superEarth: return Assets.Planets.superEarth
        case .neptunian: return Assets.Planets.neptunian
        case .terrestrial: return Assets.Planets.terrestrial
        }
    }
}
