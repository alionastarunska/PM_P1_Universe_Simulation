//
//  SolarSystem.swift
//  Project_1_Starunska_Aliona
//
//  Created by Aliona Starunska on 18.01.2021.
//

import Foundation

protocol SolarSystemDelegate: class {
    func solarSystem(_ system: SolarSystem, didCollapseBecause blackhole: Star)
}

class SolarSystem: GalaxyChild {
    
    var starChangeHandler: ((Star) -> Void)?
    var planetsChangeHandler: (([Planet]) -> Void)?
    
    var weight: Int {
        return host.weight + planets.map({ $0.weight }).reduce(0, +)
    }
    
    weak var parent: SolarSystemDelegate?
    
    private(set) var name: String
    private(set) var host: Star {
        didSet {
            starChangeHandler?(host)
        }
    }
    private(set) var planets: [Planet] {
        didSet {
            planetsChangeHandler?(planets)
        }
    }
    
    init(name: String = .randomSolarSystemName ,host: Star, planets: [Planet] = [], parent: SolarSystemDelegate) {
        self.name = name
        self.host = host
        self.planets = planets
        self.parent = parent
    }
    
    // MARK: - Private
    
    private func createPlanetIfNeeded(_ currentTime: Int) {
        if currentTime % .planetCreationTime == .zero, planets.count < .maxPlanets {
            planets.append(Randomizer.makePlanet())
        }
    }
}

// MARK: - StarDelegate

extension SolarSystem: StarDelegate {
    func starDidBecomeBlackHole(star: Star) {
        planets.removeAll()
        parent?.solarSystem(self, didCollapseBecause: star)
    }
}

// MARK: - TimerHandler

extension SolarSystem: TimerHandler {
    func handleTick(_ seconds: Int) {
        createPlanetIfNeeded(seconds)
        host.handleTick(seconds)
    }
}

// MARK: - Equatable

extension SolarSystem: Equatable {
    static func == (lhs: SolarSystem, rhs: SolarSystem) -> Bool {
        return lhs.name == rhs.name && lhs.host == rhs.host
    }
}

// MARK: - Constants

private extension Int {
    static var planetCreationTime: Int { return 10 }
    static var maxPlanets: Int { return 9 }
}
