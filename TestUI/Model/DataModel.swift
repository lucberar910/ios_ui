//
//  DataModel.swift
//  TestUI
//
//  Created by Luca Berardinelli on 06/07/21.
//

import Foundation
import UIKit

class DataModel {
    var id : Int?
    var first_name : String?
    var height_feet : Int?
    var height_inches : Int?
    var last_name : String?
    var position : String?
    var weight_pounds : Int?
    var team : String?
    
    init() {
        self.id = 123
        self.first_name = "Mario"
        self.last_name = "Rossi"
        self.height_feet = 3
        self.height_inches = 4
        self.position = "Center"
        self.weight_pounds = 80
        self.team = "juve"
    }
}

class Team {
    var name : String?
    var logo : UIImage?
    
    init(name : String, logo : UIImage) {
        self.name = name
        self.logo = logo
    }
    
    static func getTeams() -> [Team] {
       return [
            Team(name: "Juve", logo: #imageLiteral(resourceName: "234043823-390c6553-ad33-4f97-8606-6d050b73c2a1")),
            Team(name: "Milan", logo: #imageLiteral(resourceName: "490px-Logo_of_AC_Milan.svg")),
            Team(name: "Inter", logo: #imageLiteral(resourceName: "Inter logo")),
            Team(name: "Roma", logo: #imageLiteral(resourceName: "1200px-AS_Roma_Logo_2017.svg")),
            Team(name: "Napoli", logo: #imageLiteral(resourceName: "SSC_Napoli_2007.svg"))
        ]
    }
}
