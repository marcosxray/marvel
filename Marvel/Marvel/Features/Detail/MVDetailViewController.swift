//
//  MVDetailViewController.swift
//  Marvel
//
//  Created by Marcos Borges on 10/04/2018.
//  Copyright © 2018 Marcos Borges. All rights reserved.
//

import UIKit
import RxSwift

// MARK: - Class

class MVDetailViewController: BaseViewController {
    
    // MARK: - Public variables
    
    var viewModel: MVDetailViewModel!
    
    // MARK: - Private variables
    
    private var bag = DisposeBag()
    
    // MARK: - outlets
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var photoImageView: UIImageView!
    
    // MARK: - Overridden methods

    override func viewDidLoad() {
        super.viewDidLoad()

        setupRx()
        viewModel.getCharacter()
    }
    
    // MARK: - Private methods
    
    private func setupRx() {
        viewModel.character.asObservable().subscribe(onNext: { [weak self] character in
            guard let newChar = character else { return }
            self?.updateInfo(character: newChar)
        }).disposed(by: bag)
        
        viewModel.showLoader.subscribe(onNext: { [weak self] value in
            self?.showLoader.onNext(value)
        }).disposed(by: bag)
    }
    
    private func updateInfo(character: MVCharacter) {
        self.title = character.name
        self.titleLabel.text = character.name
        self.subtitleLabel.text = character.description
        
        let imageUrl = character.thumbnailUrl + "." + character.thumbnailExtension
        self.photoImageView.download(image: imageUrl)
    }
}
