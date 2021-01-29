//
//  SolarSystemCell.swift
//  Project_1_Starunska_Aliona
//
//  Created by Aliona Starunska on 20.01.2021.
//

import UIKit

class SolarSystemCell: CollectionViewCell {
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var hostStarLabel: UILabel!
    @IBOutlet private weak var numberOfPlanetsLabel: UILabel!
    
    func configure(with item: SolarSystem) {
        nameLabel.text = item.name
        hostStarLabel.text = item.host.name + "-" + item.host.type.rawValue
        numberOfPlanetsLabel.text = "\(item.planets.count)"
    }
}
