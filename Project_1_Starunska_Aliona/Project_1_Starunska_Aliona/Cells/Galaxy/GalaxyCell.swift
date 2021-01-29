//
//  GalaxyCell.swift
//  Project_1_Starunska_Aliona
//
//  Created by Aliona Starunska on 19.01.2021.
//

import UIKit

class GalaxyCell: CollectionViewCell {
    @IBOutlet private weak var galaxyImageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var typeLabel: UILabel!
    @IBOutlet private weak var ageLabel: UILabel!
    
    func configure(with item: Galaxy) {
        galaxyImageView.image = item.type.image
        nameLabel.text = item.name
        typeLabel.text = item.type.rawValue
        ageLabel.text = item.age.time
    }
}
