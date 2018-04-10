//
//  MVHomeViewController.swift
//  Marvel
//
//  Created by Marcos Borges on 09/04/2018.
//  Copyright © 2018 Marcos Borges. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

// MARK: - Class

class MVHomeViewController: BaseViewController {
    
    // MARK: - Public variables
    
    var viewModel: MVHomeViewModel!
    
    // MARK: - Private variables
    
    private var bag = DisposeBag()
    
    // MARK: - Outlets
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var reloadButton: UIButton!
    
    // MARK: - Overridden methods

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Heroes"
        tableView.estimatedRowHeight = 100.0
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.tableFooterView = UIView(frame: .zero)
        
        setupRx()
        viewModel.getCharacters()
    }
    
    // MARK: - Private methods
    
    private func setupRx() {
        viewModel.dataSourceDidUpdate.asObservable().subscribe(onNext: { [weak self] _ in
            self?.refreshList()
        }).disposed(by: bag)
        
        reloadButton.rx.tap
            .subscribe(){ [weak self] _ in
                self?.viewModel.getCharacters()
            }.disposed(by: bag)
        
        viewModel.showLoader.subscribe(onNext: { [weak self] value in
            self?.showLoader.onNext(value)
        }).disposed(by: bag)
    }
    
    private func refreshList() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

// MARK: - UITableViewDataSource

extension MVHomeViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "homeCell") as? MVHomeCell else {
            return UITableViewCell()
        }
        
        let character = viewModel.dataSource[indexPath.row]
        cell.configCell(character: character)
        
        return cell
    }
}

// MARK: - UITableViewDelegate

extension MVHomeViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let character = viewModel.dataSource[indexPath.row]
        viewModel.characterDidSelect(character: character)
    }
}
