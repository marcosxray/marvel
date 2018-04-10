//
//  MVHomeViewModel.swift
//  Marvel
//
//  Created by Marcos Borges on 09/04/2018.
//  Copyright © 2018 Marcos Borges. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

// MARK: - Class

class MVHomeViewModel {

    // MARK: - Public variables
    
    var dataSource: [MVCharacter] = []
    var dataSourceDidUpdate = PublishSubject<Void>()
    var showLoader = BehaviorSubject<Bool>(value: false)
    
    // MARK: - Private variables
    
    private var router: MVRouter
    private var service: MVNetworkService
    private var apireq: MVApiRequest
    private var model: MVCharactersModel
    private var bag = DisposeBag()
    private var offset = 0
    private let increment = 10
    
    // MARK: - Initialization
    
    init(router: MVRouter, service: MVNetworkService, apireq: MVApiRequest, model: MVCharactersModel) {
        self.router = router
        self.service = service
        self.apireq = apireq
        self.model = model
    }
    
    // MARK: - Public methods
    
    func getCharacters() {
        
        showLoader.onNext(true)
        
        model.getCharacters(offset: self.offset, count: increment).subscribe(onNext: { [weak self] status in
            
            self?.showLoader.onNext(false)
            
            switch status {
            case .success(let characters):
                self?.dataSource.append(contentsOf: characters)
                self?.dataSourceDidUpdate.onNext(())
            case .error(let message):
                print(message)
            default:
                break
            }
            
        }).disposed(by: bag)
        
        self.offset += increment
    }
    
    func characterDidSelect(character: MVCharacter) {
        router.gotoDetail(url: character.url)
    }
}
