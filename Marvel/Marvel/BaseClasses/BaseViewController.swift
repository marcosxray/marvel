//
//  BaseViewController.swift
//  Marvel
//
//  Created by Marcos Borges on 10/04/2018.
//  Copyright © 2018 Marcos Borges. All rights reserved.
//

import UIKit
import RxSwift
import MBProgressHUD

// MARK: - Class

class BaseViewController: UIViewController {
    
    // MARK: - Public variables
    
    var showLoader = BehaviorSubject<Bool>(value: false)
    
    // MARK: - Private variables
    
    private var bag = DisposeBag()
    
    // MARK: - Overridden methods

    override func viewDidLoad() {
        super.viewDidLoad()
        setupLoader()
    }

    // MARK: - Loader
    
    func setupLoader() {
        showLoader.asObservable().subscribe(onNext: { [weak self] value in
            guard let realSelf = self else { return }
            DispatchQueue.main.async {
                switch value {
                case true:
                    MBProgressHUD.showAdded(to: realSelf.view, animated: true)
                    break
                case false:
                    MBProgressHUD.hide(for: realSelf.view, animated: true)
                    break
                }
            }
        }).disposed(by: bag)
    }
}
