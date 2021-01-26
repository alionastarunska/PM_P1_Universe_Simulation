//
//  UniverseViewController.swift
//  Project_1_Starunska_Aliona
//
//  Created by Aliona Starunska on 19.01.2021.
//

import UIKit

class UniverseViewController: UIViewController {
    
    @IBOutlet private weak var collectionView: UICollectionView!
    private let timerService: TimerService = DefaultTimerService()
    private let datasource = CollectionViewDataSource<GalaxyCell>(items: [])

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        setupHandler()
        timerService.start()
    }

    // MARK: - Private
    
    private func setupHandler() {
        Universe.shared.changeHandler = { [unowned self] galaxies in
            self.datasource.set(items: galaxies)
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = .cellSize
        layout.sectionInset = UIEdgeInsets(top: .sectionInset, left: .zero, bottom: .sectionInset, right: .zero)
        collectionView.collectionViewLayout = layout
        collectionView.register(GalaxyCell.self)
        collectionView.dataSource = datasource
        collectionView.delegate = self
    }
}

// MARK: - CollectionViewDelegate

extension UniverseViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let galaxy = Universe.shared.galaxies[indexPath.row]
        guard let galaxyViewController: GalaxyViewController = storyboard?.get() else { return }
        galaxyViewController.galaxy = galaxy
        navigationController?.pushViewController(galaxyViewController, animated: true)
    }
}

// MARK: - Constants

fileprivate extension CGFloat {
    static var sectionInset: CGFloat { return 16 }
    static var itemInset: CGFloat { return 10 }
    static var cellHeight: CGFloat { return 200 }
}

fileprivate extension CGSize {
    static var cellSize: CGSize {
        let width: CGFloat = (UIScreen.main.bounds.width - (2 * .sectionInset) - .itemInset) / 2
        return CGSize(width: width, height: .cellHeight)
    }
}
