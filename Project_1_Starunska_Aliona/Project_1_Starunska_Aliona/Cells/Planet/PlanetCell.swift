//
//  PlanetCell.swift
//  Project_1_Starunska_Aliona
//
//  Created by Aliona Starunska on 20.01.2021.
//

import UIKit

class PlanetCell: CollectionViewCell {

    @IBOutlet private weak var planetImageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var typeLabel: UILabel!
    
    func configure(with item: Planet) {
        planetImageView.image = item.type.image
        nameLabel.text = item.name
        typeLabel.text = item.type.rawValue
    }
}
