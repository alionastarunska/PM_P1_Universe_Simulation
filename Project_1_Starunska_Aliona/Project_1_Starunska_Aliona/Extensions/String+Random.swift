//
//  String+Random.swift
//  Project_1_Starunska_Aliona
//
//  Created by Aliona Starunska on 25.01.2021.
//

import Foundation

extension String {
    
    static var randomGalaxyName: String{
        return [randomCharacter, randomCharacter, "-", "\(UInt32(arc4random_uniform(1000)))", randomCharacter].joined()
    }
    
    static var randomSolarSystemName: String{
        return [randomCharacter, randomCharacter, randomCharacter, "-", "\(UInt32(arc4random_uniform(100)))"].joined()
    }
    
    static var randomStarName: String{
        var characters = Array<String>()
        for _ in 0..<(2 + Int(arc4random_uniform(8))) {
            characters.append(randomCharacter)
        }
        return characters.joined()
    }
    
    static var randomPlanetName: String{
        var characters = Array<String>()
        for _ in 0..<(2 + Int(arc4random_uniform(3))) {
            characters.append(randomCharacter)
        }
        characters.append("\(UInt32(arc4random_uniform(100)))")
        return characters.joined()
    }
    
    // MARK: - Private
    
    private static var randomCharacter: String{
        let letters = "abcdefghijklmnopqrstuvwxyz"
        return String(letters.map({ $0 }).randomElement() ?? "a").uppercased()
    }
}
