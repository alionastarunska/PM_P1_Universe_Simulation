//
//  Star.swift
//  Project_1_Starunska_Aliona
//
//  Created by Aliona Starunska on 18.01.2021.
//

import UIKit

protocol StarDelegate: class {
    func starDidBecomeBlackHole(star: Star)
}

class Star: GalaxyChild {
    
    enum Kind: String, RandomizableEnum {
        case denseDwarf = "Dense dwarf"
        case blackHole = "Black hole"
        case superGiant = "Super giant"
        case blueGiant = "Blue giant"
        case redGiant = "Red giant"
        case yellowDwarf = "Yellow dwarf"
        case redDwarf = "Red dwarf"
    }
    
    enum EvolutionaryStage: String, RandomizableEnum {
        case young = "Young"
        case old = "Old"
        case final = "Final"
    }
    
    weak var parent: StarDelegate?
    
    var changeHandler: ((Star) -> Void)?
    
    private(set) var name: String
    private(set) var type: Kind
    private(set) var evolution: EvolutionaryStage
    private(set) var weight: Int
    private(set) var temperature: Int
    private(set) var radius: Int
    private(set) var luminosity: Int
    
    // MARK: - Lifecycle
    
    init(name: String = .randomStarName,
         type: Star.Kind = EvolutionaryStage.young.availableTypes.randomElement()!,
         evolution: Star.EvolutionaryStage = .young,
         weight: Int = .random,
         temperature: Int = .random,
         radius: Int = .random,
         luminosity: Int = .random) {
        self.name = name
        self.type = type
        self.evolution = evolution
        self.weight = weight
        self.temperature = temperature
        self.radius = radius
        self.luminosity = luminosity
    }
    
    // MARK: - Private
    
    private func evolve() {
        switch evolution {
        case .young:
            evolution = .old
            type = evolution.availableTypes.randomElement()!
        case .old:
            evolution = .final
            if Universe.shared.shouldMakeStarBlackHole(star: self) {
                type = .blackHole
                parent?.starDidBecomeBlackHole(star: self)
            } else {
                type = .denseDwarf
            }
        case .final:
            return
        }
    }
}

// MARK: - TimerHandler

extension Star: TimerHandler {
    func handleTick(_ seconds: Int) {
        if seconds % .evolutionTime == 0 {
            evolve()
            changeHandler?(self)
        }
    }
}

// MARK: - Equatable

extension Star: Equatable {
    static func == (lhs: Star, rhs: Star) -> Bool {
        return lhs.name == rhs.name && lhs.type == rhs.type && lhs.evolution == rhs.evolution
    }
}

// MARK: - Constant

private extension Int {
    static var evolutionTime: Int { return 60 }
}

extension Star.EvolutionaryStage {
    var availableTypes: [Star.Kind] {
        switch self {
        case .young: return [.yellowDwarf, .redDwarf]
        case .old: return [.redGiant, .blueGiant, .superGiant]
        case .final: return [.blackHole, .denseDwarf]
        }
    }
}

extension Star.Kind {
    var image: UIImage {
        switch self {
        case .denseDwarf: return Assets.Stars.denseDwarf
        case .blackHole: return Assets.Stars.blackHole
        case .superGiant: return Assets.Stars.superGiant
        case .blueGiant: return Assets.Stars.blueGiant
        case .redGiant: return Assets.Stars.redGiant
        case .yellowDwarf: return Assets.Stars.yellowDwarf
        case .redDwarf: return Assets.Stars.redDwarf
        }
    }
}

