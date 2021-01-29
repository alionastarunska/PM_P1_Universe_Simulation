//
//  StarViewController.swift
//  Project_1_Starunska_Aliona
//
//  Created by Aliona Starunska on 28.01.2021.
//

import UIKit

class StarViewController: UIViewController {
    
    weak var star: Star?
    
    @IBOutlet private weak var starImageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var statusLabel: UILabel!
    @IBOutlet private weak var typeLabel: UILabel!
    @IBOutlet private weak var radiusLabel: UILabel!
    @IBOutlet private weak var luminosityLabel: UILabel!
    @IBOutlet private weak var temperatureLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Star"
        star?.changeHandler = { [weak self] _ in
            self?.setupView()
        }
        setupView()
    }
    
    // MARK: - Private
    
    private func handleBlackHole() {
        let alert = UIAlertController.make(with: "The star (host) - \(star?.name ?? "") became a black hole") { [weak self] in
            if let galaxyViewController = self?.navigationController?.viewControllers.first(where: { $0 is GalaxyViewController }) {
                self?.navigationController?.popToViewController(galaxyViewController, animated: true)
            }
        }
        present(alert, animated: true, completion: nil)
    }
    
    private func setupView() {
        starImageView.image = star?.type.image
        nameLabel.text = star?.name
        statusLabel.text = star?.evolution.rawValue
        typeLabel.text = star?.type.rawValue
        radiusLabel.text = "\(star?.radius ?? 0)"
        luminosityLabel.text = "\(star?.luminosity ?? 0)"
        temperatureLabel.text = "\(star?.temperature ?? 0)"
    }
}
