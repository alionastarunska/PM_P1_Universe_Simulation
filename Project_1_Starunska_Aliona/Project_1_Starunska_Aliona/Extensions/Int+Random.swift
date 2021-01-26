//
//  Int+Random.swift
//  Project_1_Starunska_Aliona
//
//  Created by Aliona Starunska on 25.01.2021.
//

import Foundation

extension Int {
    static var random: Int {
        return Int(arc4random_uniform(100))
    }
    
    static var randomBoundary: Int {
        return 70 + Int(arc4random_uniform(30))
    }
}
