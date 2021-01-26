//
//  Assets.swift
//  Project_1_Starunska_Aliona
//
//  Created by Aliona Starunska on 19.01.2021.
//

import UIKit

enum Assets {
    enum Galaxies {
        static var eliptical: UIImage { return UIImage(named: "galaxy-elliptical") ?? UIImage() }
        static var spiral: UIImage { return UIImage(named: "galaxy-spiral") ?? UIImage() }
        static var irregular: UIImage { return UIImage(named: "galaxy-irregular") ?? UIImage() }
        static var lense: UIImage { return UIImage(named: "galaxy-lense") ?? UIImage() }
    }
    enum Planets {
        static var gasGiant: UIImage { return UIImage(named: "planet-gasGiant") ?? UIImage() }
        static var superEarth: UIImage { return UIImage(named: "planet-superEarth") ?? UIImage() }
        static var neptunian: UIImage { return UIImage(named: "planet-neptunian") ?? UIImage() }
        static var terrestrial: UIImage { return UIImage(named: "planet-terrestrial") ?? UIImage() }
    }
    
    enum Stars {
        static var denseDwarf: UIImage { return UIImage(named: "star-denseDwarf") ?? UIImage() }
        static var blackHole: UIImage { return UIImage(named: "star-blackHole") ?? UIImage() }
        static var superGiant: UIImage { return UIImage(named: "star-superGiant") ?? UIImage() }
        static var blueGiant: UIImage { return UIImage(named: "star-blueGiant") ?? UIImage() }
        static var redGiant: UIImage { return UIImage(named: "star-redGiant") ?? UIImage() }
        static var yellowDwarf: UIImage { return UIImage(named: "star-yellowDwarf") ?? UIImage() }
        static var redDwarf: UIImage { return UIImage(named: "star-redDwarf") ?? UIImage() }
    }
}

