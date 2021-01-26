//
//  Galaxy.swift
//  Project_1_Starunska_Aliona
//
//  Created by Aliona Starunska on 18.01.2021.
//

import UIKit

protocol GalaxyChild: TimerHandler {
    var name: String { get }
    var weight: Int { get }
}

class Galaxy {
    
    var changeHandler: (([GalaxyChild]) -> Void)?
    var collapseHandler: Event?
    
    // MARK: - Kind
    
    enum Kind: String, RandomizableEnum {
        case elliptical
        case spiral
        case irregular
        case lense
    }
    
    // MARK: - Properties
    var weight: Int {
        return children.map({ $0.weight }).reduce(.zero, +)
    }
    
    var age: Int {
        guard let currentTime = universe?.currentTime else { return 0 }
        return currentTime - birthTime
    }
    
    private(set) weak var universe: Universe?
    
    private(set) var name: String
    private(set) var type: Kind
    private(set) var birthTime: Int
    private(set) var children: [GalaxyChild] {
        didSet {
            changeHandler?(children)
        }
    }
    
    // MARK: - Lifecycle
    
    internal init(universe: Universe? = nil, name: String = .randomGalaxyName, type: Galaxy.Kind, birthTime: Int, children: [GalaxyChild] = []) {
        self.universe = universe
        self.name = name
        self.type = type
        self.birthTime = birthTime
        self.children = children
    }
    
    deinit {
        collapseHandler?()
    }
}

// MARK: - TimerHandler

extension Galaxy: TimerHandler {
    
    func handleTick(_ seconds: Int) {
        children.forEach({
            $0.handleTick(seconds)
        })
        if seconds % .systemCreatingTime == .zero {
            children.append(Randomizer.makeSolarSystem(self))
        }
    }
}

// MARK: - Galaxy Collisions

extension Galaxy {
    /// Custom operator used to simulate galaxies collision
    /// for example galaxyA + galaxyB = galaxyC where galaxyC has type and age of heavier galaxy (A or B)
    /// solar systems appends, but 10% of them are destroyed randomly
    static func +(lhs: Galaxy, rhs: Galaxy) -> Galaxy {
        var children = lhs.children + rhs.children
        var solarSystems = children.compactMap({ $0 as? SolarSystem })
        let numberOfSystemsToDelete = Int(Float(solarSystems.count) * .systemCollapseTreshold)
        for _ in 0..<numberOfSystemsToDelete {
            let randomIndex = Int(arc4random_uniform(UInt32(solarSystems.count)))
            if let systemIndex = children.firstIndex(where: { ($0 as? SolarSystem) == solarSystems[randomIndex] }) {
                children.remove(at: systemIndex)
            }
            solarSystems.remove(at: randomIndex)
        }
        let name = [lhs.name, rhs.name].joined(separator: " & ")
        let greaterGalaxy = lhs > rhs
        let type = greaterGalaxy.type
        let birthTime = greaterGalaxy.birthTime
        let universe = greaterGalaxy.universe
        return Galaxy(universe: universe, name: name, type: type, birthTime: birthTime, children: children)
    }
    
    /// Custom operator used to select heavier galaxy
    static func >(lhs: Galaxy, rhs: Galaxy) -> Galaxy {
        return lhs.weight >= rhs.weight ? lhs : rhs
    }
}

// MARK: - Galaxy.Kind Image

extension Galaxy.Kind {
    var image: UIImage {
        switch self {
        case .elliptical: return Assets.Galaxies.eliptical
        case .irregular: return Assets.Galaxies.irregular
        case .spiral: return Assets.Galaxies.spiral
        case .lense: return Assets.Galaxies.lense
        }
    }
}

// MARK: - BlackHoleDelegate

extension Galaxy: SolarSystemDelegate {
    
    func solarSystem(_ system: SolarSystem, didCollapseBecause blackhole: Star) {
        let index = children.firstIndex(where: {
            if let solarSystem = $0 as? SolarSystem, solarSystem == system {
                return true
            }
            return false
        })
        guard let systemIndex = index else { return }
        children.insert(blackhole, at: systemIndex)
        children.remove(at: systemIndex + 1)
    }
}

// MARK: - Equatable

extension Galaxy: Equatable {
    static func == (lhs: Galaxy, rhs: Galaxy) -> Bool {
        return lhs.name == rhs.name && lhs.age == rhs.age && lhs.type == rhs.type
    }
}

// MARK: - Constants

fileprivate extension Int {
    static var systemCreatingTime: Int { return 10 }
}

fileprivate extension Float {
    static var systemCollapseTreshold: Float { return 0.1 }
}
