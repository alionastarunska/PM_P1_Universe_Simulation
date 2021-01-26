//
//  StarCell.swift
//  Project_1_Starunska_Aliona
//
//  Created by Aliona Starunska on 20.01.2021.
//

import UIKit

class StarCell: CollectionViewCell {

    @IBOutlet private weak var starImageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var evolutionLabel: UILabel!
    @IBOutlet private weak var typeLabel: UILabel!
    
    func configure(with item: Star) {
        starImageView.image = item.type.image
        nameLabel.text = item.name
        typeLabel.text = item.type.rawValue
        evolutionLabel.text = item.evolution.rawValue
    }

}
