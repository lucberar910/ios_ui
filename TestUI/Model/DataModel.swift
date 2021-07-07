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
