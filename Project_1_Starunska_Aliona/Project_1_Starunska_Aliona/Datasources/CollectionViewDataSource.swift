//
//  CollectionViewDataSource.swift
//  Project_1_Starunska_Aliona
//
//  Created by Aliona Starunska on 19.01.2021.
//

import UIKit

class CollectionViewDataSource<Cell: CollectionViewCell>: NSObject, UICollectionViewDataSource {
    
    private var items: [Cell.Item]
    
    internal init(items: [Cell.Item]) {
        self.items = items
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Cell.reuseIdentifier, for: indexPath) as? Cell
        cell?.configure(with: items[indexPath.row])
        return cell ?? UICollectionViewCell()
    }
}

// MARK: - Public

extension CollectionViewDataSource {
    func set(items: [Cell.Item]) {
        self.items = items
    }
}
