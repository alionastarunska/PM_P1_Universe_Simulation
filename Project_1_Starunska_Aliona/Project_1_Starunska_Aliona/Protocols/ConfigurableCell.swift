//
//  AppDelegate.swift
//  Project_1_Starunska_Aliona
//
//  Created by Aliona Starunska on 18.01.2021.
//

import UIKit

protocol ConfigurableCell {
    associatedtype Item
    
    func configure(with item: Item)
}
