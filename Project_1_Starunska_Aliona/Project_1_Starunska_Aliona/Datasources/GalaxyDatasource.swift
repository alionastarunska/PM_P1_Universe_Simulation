//
//  GalaxyDatasource.swift
//  Project_1_Starunska_Aliona
//
//  Created by Aliona Starunska on 27.01.2021.
//

import UIKit

class GalaxyDatasource: NSObject, UICollectionViewDataSource {
    
    private var items: [GalaxyChild]
    
    internal init(items: [GalaxyChild]) {
        self.items = items
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = items[indexPath.row]
        if let system = item as? SolarSystem {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SolarSystemCell.reuseIdentifier, for: indexPath) as? SolarSystemCell
            cell?.configure(with: system)
            return cell ?? UICollectionViewCell()
        } else if let star = item as? Star {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StarCell.reuseIdentifier, for: indexPath) as? StarCell
            cell?.configure(with: star)
            return cell ?? UICollectionViewCell()
        }
        return UICollectionViewCell()
    }
}

// MARK: - Public

extension GalaxyDatasource {
    func set(items: [GalaxyChild]) {
        self.items = items
    }
}
