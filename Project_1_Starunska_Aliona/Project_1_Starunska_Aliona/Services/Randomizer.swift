//
//  Randomizer.swift
//  Project_1_Starunska_Aliona
//
//  Created by Aliona Starunska on 19.01.2021.
//

import UIKit

class Randomizer {

    static func makeGalaxy(universe: Universe) -> Galaxy {
        return Galaxy(universe: universe, type: .random, birthTime: universe.currentTime)
    }

    static func makeSolarSystem(_ parent: SolarSystemDelegate) -> SolarSystem {
        let host = makeStar()
        let system = SolarSystem(host: host, parent: parent)
        host.parent = system
        return system
    }

    static func makePlanet() -> Planet {
        var satelites: [Planet] = []
        let random = Int(arc4random_uniform(.maxSatelites))
        if random > 0 {
            for _ in 0..<random {
                satelites.append(makeSatelite())
            }
        }
        return Planet(satelites: [])
    }
    
    // MARK: - Private
    
    private static func makeStar() -> Star {
        return Star()
    }
    
    private static func makeSatelite() -> Planet {
        return Planet()
    }
}

// MARK: - Constants
fileprivate extension UInt32 {
    static var maxSatelites: UInt32 { return 5 }
}
