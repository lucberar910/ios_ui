//
//  TestUIViewModel.swift
//  TestUI
//
//  Created by Luca Berardinelli on 06/07/21.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation
import Combine

class TestUIViewModel: ViewModel {
    // MARK: - Architecture properties
    var data = PassthroughSubject<DataModel, Never>()
    
    // MARK: - Business logic properties
    
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Object lifecycle
    
    init() {
    }
    
    func getData(){
        let objData = DataModel.init()
        self.data.send(objData)
    }

    // MARK: - Internal methods
    
    // Declare functions that call use cases here
}
