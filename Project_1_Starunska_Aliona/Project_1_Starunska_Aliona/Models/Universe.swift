//
//  Universe.swift
//  Project_1_Starunska_Aliona
//
//  Created by Aliona Starunska on 18.01.2021.
//

import Foundation

class Universe {
    
    var changeHandler: (([Galaxy]) -> Void)?
    
    private(set) var galaxies: [Galaxy] {
        didSet {
            changeHandler?(galaxies)
        }
    }
    private(set) var currentTime: Int
    
    /// Minimum radius of star to become blackhole
    private let radiusOfBlackHole: Int
    /// Minimum weight of star to become blackhole
    private let weightOfBlackHole: Int
    
    // MARK: - Singleton
    static let shared = Universe()
    private init() {
        galaxies = []
        currentTime = .zero
        radiusOfBlackHole = .randomBoundary
        weightOfBlackHole = .randomBoundary
    }
    
    // MARK: - Public
    
    func shouldMakeStarBlackHole(star: Star) -> Bool {
        return star.radius >= radiusOfBlackHole && star.weight >= weightOfBlackHole
    }
    
    // MARK: - Private
    
    private func performCollision() {
        var oldGalaxies = galaxies.filter({ $0.age > .galaxyCollisionAge })
        guard oldGalaxies.count > 1,
              let firstGalaxy = oldGalaxies.randomElement() else {
            return
        }
        oldGalaxies.removeAll(where: { $0 == firstGalaxy })
        guard let secondGalaxy = oldGalaxies.randomElement() else { return }
        let newGalaxy = firstGalaxy + secondGalaxy
        if let index = galaxies.firstIndex(of: firstGalaxy > secondGalaxy) {
            galaxies.insert(newGalaxy, at: index)
        } else {
            galaxies.append(newGalaxy)
        }
        galaxies.removeAll(where: { $0 == firstGalaxy || $0 == secondGalaxy })
    }
}

// MARK: - TimerHandler

extension Universe: TimerHandler {
    
    func handleTick(_ seconds: Int) {
        currentTime = seconds
        galaxies.forEach({
            $0.handleTick(seconds)
        })
        
        guard seconds > .zero else { return }
        if seconds % .galaxyCreatingTime == .zero {
            galaxies.append(Randomizer.makeGalaxy(universe: self))
        }
        if seconds % .galaxyCollisionTime == .zero {
            performCollision()
        }
    }
}


// MARK: - Constants

fileprivate extension Int {
    static var galaxyCreatingTime: Int { return 10 }
    static var galaxyCollisionTime: Int { return 30 }
    static var galaxyCollisionAge: Int { return 180 }
}
