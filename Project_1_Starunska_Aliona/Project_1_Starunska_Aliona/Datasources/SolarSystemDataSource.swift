//
//  SolarSystemDataSource.swift
//  Project_1_Starunska_Aliona
//
//  Created by Aliona Starunska on 29.01.2021.
//

import UIKit

class SolarSystemDataSource: NSObject, UICollectionViewDataSource {
    
    private var system: SolarSystem?
    
    init(system: SolarSystem? = nil) {
       self.system = system
   }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return section == .zero ? 1 : system?.planets.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == .zero, let star = system?.host {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StarCell.reuseIdentifier, for: indexPath)
            (cell as? StarCell)?.configure(with: star)
            return cell
        } else {
            guard let planet = system?.planets[indexPath.row] else { return UICollectionViewCell() }
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PlanetCell.reuseIdentifier, for: indexPath)
            (cell as? PlanetCell)?.configure(with: planet)
            return cell
        }
    }
}

// MARK: - Public

extension SolarSystemDataSource {
    func set(system: SolarSystem?) {
        self.system = system
    }
}
