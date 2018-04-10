//
//  MVCharactersModelMock.swift
//  MarvelTests
//
//  Created by Marcos Aires Borges on 10/04/2018.
//  Copyright © 2018 Marcos Borges. All rights reserved.
//

import Foundation
import RxSwift
@testable import Marvel

// MARK: - Class

class MVCharactersModelMockSuccess: MVCharactersModel {
    
    override func getCharacters(offset: Int, count: Int) -> Observable<MVCharacterStatus> {
        let subject = PublishSubject<MVCharacterStatus>()

        defer {
            let char1 = MVCharacter(dictionary: ["id": 01,
                                                 "name": "Name1",
                                                 "description": "Blablabla",
                                                 "thumbnail": ["path": "a",
                                                               "extension": "a"],
                                                 "path": "...",
                                                 "extension": "...",
                                                 "resourceURI": "..."])

            let char2 = MVCharacter(dictionary: ["id": 02,
                                                 "name": "Name2",
                                                 "description": "Loren ipsum",
                                                 "thumbnail": ["path": "b",
                                                               "extension": "b"],
                                                 "path": "...",
                                                 "extension": "...",
                                                 "resourceURI": "..."])

            let status: MVCharacterStatus = .success([])
            subject.onNext(status)
        }

        return subject.asObservable()
    }
}

class MVCharactersModelMockError: MVCharactersModel {
    override func getCharacters(offset: Int, count: Int) -> Observable<MVCharacterStatus> {
        let subject = PublishSubject<MVCharacterStatus>()
        
        defer {
            let status: MVCharacterStatus = .error("Some error has ocurred.")
            subject.onNext(status)
        }
        
        return subject.asObservable()
    }
}


