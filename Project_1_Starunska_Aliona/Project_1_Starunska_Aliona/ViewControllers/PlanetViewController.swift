//
//  PlanetViewController.swift
//  Project_1_Starunska_Aliona
//
//  Created by Aliona Starunska on 28.01.2021.
//

import UIKit

class PlanetViewController: UIViewController {
    
    weak var planet: Planet?
    
    @IBOutlet private weak var planetImageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var typeLabel: UILabel!
    @IBOutlet private weak var radiusLabel: UILabel!
    @IBOutlet private weak var weightLabel: UILabel!
    @IBOutlet private weak var temperatureLabel: UILabel!
    @IBOutlet private weak var collectionView: UICollectionView!
    
    private var dataSource = CollectionViewDataSource<PlanetCell>(items: [])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Planet"
        setupView()
        setupCollectionView()
    }
    
    // MARK: - Private
    
    private func setupView() {
        planetImageView.image = planet?.type.image
        nameLabel.text = planet?.name
        typeLabel.text = planet?.type.rawValue
        radiusLabel.text = "\(planet?.radius ?? 0)"
        weightLabel.text = "\(planet?.weight ?? 0)"
        temperatureLabel.text = "\(planet?.temperature ?? 0)"
    }
    
    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = .cellSize
        collectionView.collectionViewLayout = layout
        collectionView.register(PlanetCell.self)
        dataSource.set(items: planet?.satelites ?? [])
        collectionView.dataSource = dataSource
    }
}

// MARK: - Constants

fileprivate extension CGFloat {
    static var sectionInset: CGFloat { return 16 }
    static var cellHeight: CGFloat { return 120 }
}

fileprivate extension CGSize {
    static var cellSize: CGSize {
        let width: CGFloat = (UIScreen.main.bounds.width * 0.95) - (2 * .sectionInset)
        return CGSize(width: width, height: .cellHeight)
    }
}
