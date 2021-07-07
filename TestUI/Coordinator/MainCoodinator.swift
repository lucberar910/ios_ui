//
//  MainCoodinator.swift
//  TestUI
//
//  Created by Luca Berardinelli on 06/07/21.
//

import Foundation
import UIKit

class MainCoordinator : TestUICoordinableProtocol {
    var navController : UINavigationController = UINavigationController()
    var container = MainContainer()

    func start() {
        let vm = TestUIViewModel()
        let vc = TestUIViewController(coordinator: self, viewModel: vm)
        navController.pushViewController(vc, animated: true)
    }
}
