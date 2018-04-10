//
//  MVCharacter.swift
//  Marvel
//
//  Created by Marcos Borges on 09/04/2018.
//  Copyright © 2018 Marcos Borges. All rights reserved.
//

import Foundation

struct MVCharacter {
    var characterId: Int
    var name: String
    var description: String
    var thumbnailUrl: String
    var thumbnailExtension: String
    var url: String
    
    init?(dictionary: [String: Any]) {
        guard let characterId = dictionary["id"] as? Int else {
            return nil
        }
        
        guard let name = dictionary["name"] as? String else {
            return nil
        }
        
        guard let description = dictionary["description"] as? String else {
            return nil
        }
        
        guard let thumb = dictionary["thumbnail"] as? [String: Any] else {
            return nil
        }
        
        guard let thumbnailUrl = thumb["path"] as? String else {
            return nil
        }
        
        guard let thumbnailExtension = thumb["extension"] as? String else {
            return nil
        }
        
        guard let url = dictionary["resourceURI"] as? String else {
            return nil
        }
        
        self.characterId = characterId
        self.name = name
        self.description = description
        self.thumbnailUrl = thumbnailUrl
        self.thumbnailExtension = thumbnailExtension
        self.url = url
    }
}
