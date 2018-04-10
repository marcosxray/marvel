//
//  MVHomeCell.swift
//  Marvel
//
//  Created by Marcos Borges on 10/04/2018.
//  Copyright © 2018 Marcos Borges. All rights reserved.
//

import UIKit

// MARK: - Class

class MVHomeCell: UITableViewCell {
    
    // MARK: - Outlets
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var photoImageView: UIImageView!
    
    // MARK: - public methods

    func configCell(character: MVCharacter) {
        self.titleLabel.text = character.name
        self.subtitleLabel.text = character.description
        
        let imageUrl = character.thumbnailUrl + "." + character.thumbnailExtension
        self.photoImageView.download(image: imageUrl)
    }
}
