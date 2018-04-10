//
//  MVCharactersModel.swift
//  Marvel
//
//  Created by Marcos Borges on 09/04/2018.
//  Copyright © 2018 Marcos Borges. All rights reserved.
//

import Foundation
import RxSwift

// MARK: - Definitions

enum MVCharacterStatus {
    case downloading
    case success(_: [MVCharacter])
    case error(_: String)
}

class MVCharactersModel {
    
    private var apiRequest: MVApiRequest
    private var bag = DisposeBag()
    
    init(apiRequest: MVApiRequest) {
        self.apiRequest = apiRequest
    }
    
    func getCharacters(offset: Int, count: Int) -> Observable<MVCharacterStatus> {
        
        let subject = PublishSubject<MVCharacterStatus>()
        
        subject.onNext(.downloading)
        
        defer {
            apiRequest.getCharacters(offset: offset, count: count).subscribe(onNext: { status in
                
                switch status {
                case .success(let result):
                    
                    guard let body = result.body else {
                        return
                    }
                    
                    let characters = self.parseCharacters(responseDict: body)
                    subject.onNext(.success(characters))
                    
                case .error(let error):
                    subject.onNext(.error("An error has ocurred."))
                default:
                    break
                }
                
            }).disposed(by: bag)
        }
        
        return subject.asObservable()
    }
    
    func getCharacter(url: String) -> Observable<MVCharacter> {

        let subject = PublishSubject<MVCharacter>()

        defer {

            apiRequest.getCharacter(url: url).subscribe(onNext: { status in

                switch status {
                case .success(let result):

                    guard let body = result.body else {
                        return
                    }

                    let characters = self.parseCharacters(responseDict: body)
                    guard let first = characters.first else { return }
                    subject.onNext(first)

                case .error(let error):
                    print("ERROR: \(error)")
                default:
                    break
                }

            }).disposed(by: bag)
        }

        return subject.asObservable()
    }
    
    private func parseCharacters(responseDict: [String: Any]) -> [MVCharacter] {
        
        guard let data = responseDict["data"] as? [String: Any] else { return [] }
        guard let results = data["results"] as? [[String: Any]] else { return [] }
        
        var characters: [MVCharacter] = []
        
        for dict in results {
            if let character = MVCharacter(dictionary: dict) {
                characters.append(character)
            }
        }
        
        return characters
    }
}
