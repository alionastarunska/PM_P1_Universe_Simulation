//
//  GalaxyViewController.swift
//  Project_1_Starunska_Aliona
//
//  Created by Aliona Starunska on 27.01.2021.
//

import UIKit

class GalaxyViewController: UIViewController {
    
    weak var galaxy: Galaxy?
    
    @IBOutlet private weak var collectionView: UICollectionView!
    private let timerService: TimerService = DefaultTimerService()
    private let datasource = GalaxyDatasource(items: [])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = galaxy?.name
        setupCollectionView()
        setupHandlers()
    }
    
    // MARK: - Private
    
    private func setupHandlers() {
        galaxy?.changeHandler = { [weak self] children in
            DispatchQueue.main.async {
                self?.datasource.set(items: children)
                self?.collectionView.reloadData()
            }
        }
        galaxy?.collapseHandler = { [weak self] in
            DispatchQueue.main.async {
                let alert = UIAlertController.make(with: "Galaxy collapsed because of collision with another galaxy") { [weak self] in
                    self?.navigationController?.popToRootViewController(animated: true)
                }
                self?.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = .cellSize
        layout.sectionInset = UIEdgeInsets(top: .sectionInset, left: .zero, bottom: .sectionInset, right: .zero)
        collectionView.collectionViewLayout = layout
        collectionView.register(SolarSystemCell.self)
        collectionView.register(StarCell.self)
        datasource.set(items: galaxy?.children ?? [])
        collectionView.dataSource = datasource
        collectionView.delegate = self
    }
}

// MARK: - CollectionViewDelegate

extension GalaxyViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = galaxy?.children[indexPath.row]
        if let system = item as? SolarSystem {
            guard let solarSystemViewController: SolarSystemViewController = storyboard?.get() else { return }
            solarSystemViewController.system = system
            navigationController?.pushViewController(solarSystemViewController, animated: true)
        } else if let star = item as? Star {
            guard let starViewController: StarViewController = storyboard?.get() else { return }
            starViewController.star = star
            navigationController?.pushViewController(starViewController, animated: true)
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
