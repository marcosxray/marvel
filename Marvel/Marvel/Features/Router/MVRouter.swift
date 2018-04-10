//
//  MVRouter.swift
//  Marvel
//
//  Created by Marcos Borges on 10/04/2018.
//  Copyright © 2018 Marcos Borges. All rights reserved.
//

import UIKit

// MARK: - Protocol

protocol MVRouter {
    func goBack()
    func gotoHome()
    func gotoDetail(url: String)
}

// MARK: - Class

class MVRouterImplementation: MVRouter {
    
    static let shared = MVRouterImplementation()
    
    private init() {}
    private var navigationController: UINavigationController?
    
    func initialize(withNavigation navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.gotoHome()
    }
    
    func goBack() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func gotoHome() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let controller = storyboard.instantiateViewController(withIdentifier: "homeVC") as? MVHomeViewController else {
            return
        }
        
        let router = MVRouterImplementation.shared
        let service = MVNetworkServiceImplementation()
        let apiReq = MVApiRequest(networkService: service)
        let model = MVCharactersModel(apiRequest: apiReq)
        let viewModel = MVHomeViewModel(router: router,service: service, apireq: apiReq, model: model)
        
        controller.viewModel = viewModel
        self.navigationController?.show(controller, sender: nil)
    }
    
    func gotoDetail(url: String) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let controller = storyboard.instantiateViewController(withIdentifier: "detailVC") as? MVDetailViewController else {
            return
        }
        
        let router = MVRouterImplementation.shared
        let service = MVNetworkServiceImplementation()
        let apiReq = MVApiRequest(networkService: service)
        let model = MVCharactersModel(apiRequest: apiReq)
        let viewModel = MVDetailViewModel(router: router,service: service, apireq: apiReq, model: model, resourceUrl: url)
        
        controller.viewModel = viewModel
        self.navigationController?.show(controller, sender: nil)
    }
}
