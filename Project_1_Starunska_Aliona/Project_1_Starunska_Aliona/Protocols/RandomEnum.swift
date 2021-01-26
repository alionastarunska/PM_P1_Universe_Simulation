//
//  RandomEnum.swift
//  Project_1_Starunska_Aliona
//
//  Created by Aliona Starunska on 25.01.2021.
//

import Foundation

protocol RandomizableEnum: CaseIterable {
    static var random: Self { get }
}

extension RandomizableEnum {
    static var random: Self {
        return allCases.randomElement()!
    }
}
