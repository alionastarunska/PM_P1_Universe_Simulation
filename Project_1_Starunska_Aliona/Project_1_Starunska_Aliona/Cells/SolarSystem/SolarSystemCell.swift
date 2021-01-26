//
//  SolarSystemCell.swift
//  Project_1_Starunska_Aliona
//
//  Created by Aliona Starunska on 20.01.2021.
//

import UIKit

class SolarSystemCell: CollectionViewCell {
    @IBOutlet weak private var nameLabel: UILabel!
    @IBOutlet weak private var hostStarLabel: UILabel!
    @IBOutlet weak private var numberOfPlanetsLabel: UILabel!
    
    func configure(with item: SolarSystem) {
        nameLabel.text = item.name
        hostStarLabel.text = item.host.name
        numberOfPlanetsLabel.text = "\(item.planets.count)"
    }
}
