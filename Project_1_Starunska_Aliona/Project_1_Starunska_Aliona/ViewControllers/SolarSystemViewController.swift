//
//  SolarSystemViewController.swift
//  Project_1_Starunska_Aliona
//
//  Created by Aliona Starunska on 27.01.2021.
//

import UIKit

class SolarSystemViewController: UIViewController {
    
    weak var system: SolarSystem?
    
    @IBOutlet private weak var collectionView: UICollectionView!
    private let datasource = SolarSystemDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = system?.name
        setupCollectionView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupHandlers()
    }
    
    private func handleBlackHole() {
        let alert = UIAlertController.make(with: "The star (host) - \(system?.host.name ?? "") became a black hole") { [weak self] in
            if let galaxyViewController = self?.navigationController?.viewControllers.first(where: { $0 is GalaxyViewController }) {
                self?.navigationController?.popToViewController(galaxyViewController, animated: true)
            }
        }
        present(alert, animated: true, completion: nil)
    }
    
    private func setupHandlers() {
        system?.host.changeHandler = { [weak self] star in
            DispatchQueue.main.async {
                if star.type == .blackHole {
                    self?.handleBlackHole()
                    return
                }
                self?.collectionView.reloadSections(IndexSet(0...0))
            }
        }
        system?.planetsChangeHandler = { [weak self] _ in
            DispatchQueue.main.async {
                self?.collectionView.reloadSections(IndexSet(1...1))
            }
        }
    }
    
    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = .cellSize
        layout.sectionInset = UIEdgeInsets(top: .sectionInset, left: .zero, bottom: .sectionInset, right: .zero)
        collectionView.collectionViewLayout = layout
        collectionView.register(PlanetCell.self)
        collectionView.register(StarCell.self)
        datasource.set(system: system)
        collectionView.dataSource = datasource
        collectionView.delegate = self
    }
}

// MARK: - CollectionViewDelegate

extension SolarSystemViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == .zero {
            guard let starViewController: StarViewController = storyboard?.get() else { return }
            starViewController.star = system?.host
            navigationController?.pushViewController(starViewController, animated: true)
        } else {
            let planet = system?.planets[indexPath.row]
            guard let planetViewController: PlanetViewController = storyboard?.get() else { return }
            planetViewController.planet = planet
            navigationController?.pushViewController(planetViewController, animated: true)
        }
    }
}

// MARK: - Constants

fileprivate extension CGFloat {
    static var sectionInset: CGFloat { return 16 }
    static var cellHeight: CGFloat { return 120 }
}

fileprivate extension CGSize {
    static var cellSize: CGSize {
        let width: CGFloat = UIScreen.main.bounds.width - (2 * .sectionInset)
        return CGSize(width: width, height: .cellHeight)
    }
}
