//
//  CollectionView+Register.swift
//  Project_1_Starunska_Aliona
//
//  Created by Aliona Starunska on 19.01.2021.
//

import UIKit

extension UITableView {
    func register<T: ReusableCell>(_ type: T.Type) {
        register(type.cellNib, forCellReuseIdentifier: type.reuseIdentifier)
    }
}

extension UICollectionView {
    func register<T: ReusableCell>(_ type: T.Type) {
        register(type.cellNib, forCellWithReuseIdentifier: type.reuseIdentifier)
    }
}
