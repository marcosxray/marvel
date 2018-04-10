//
//  MVDetailViewModel.swift
//  Marvel
//
//  Created by Marcos Borges on 10/04/2018.
//  Copyright © 2018 Marcos Borges. All rights reserved.
//

import Foundation
import RxSwift

// MARK: - Class

class MVDetailViewModel {
    
    // MAR: - Public variables
    
    var character = BehaviorSubject<MVCharacter?>(value: nil)
    var showLoader = BehaviorSubject<Bool>(value: false)
    
    // MARK: - Private variables
    
    private var router: MVRouter
    private var service: MVNetworkService
    private var apireq: MVApiRequest
    private var model: MVCharactersModel
    private var resourceUrl: String
    private var bag = DisposeBag()
    
    // MARK: - Initialization
    
    init(router: MVRouter, service: MVNetworkService, apireq: MVApiRequest, model: MVCharactersModel, resourceUrl: String) {
        self.router = router
        self.service = service
        self.apireq = apireq
        self.model = model
        self.resourceUrl = resourceUrl
    }
    
    // MARK: - Public methods
    
    func getCharacter() {
        
        showLoader.onNext(true)
        
        model.getCharacter(url: resourceUrl).asObservable().subscribe(onNext: { [weak self] character in
            self?.showLoader.onNext(false)
            self?.character.onNext(character)
        }).disposed(by: bag)
    }
}
