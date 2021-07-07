//
//  Coordinable.swift
//  TestUI
//
//  Created by Luca Berardinelli on 06/07/21.
//

import Foundation
protocol Coordinable {
    associatedtype ViewModelType : ViewModel
    var viewModel : ViewModelType { get set }
}
