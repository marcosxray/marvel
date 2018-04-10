//
//  MVApiRequestTests.swift
//  MarvelTests
//
//  Created by Marcos Borges on 10/04/2018.
//  Copyright © 2018 Marcos Borges. All rights reserved.
//

import XCTest
import RxSwift
@testable import Marvel

class MVApiRequestTests: XCTestCase {
    
    var bag = DisposeBag()
    
    override func setUp() {
        super.setUp()
        
        bag = DisposeBag()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    // MARK: - Tests
    
    func testGetCharactersSuccess() {
        
        let expectation = XCTestExpectation(description: "Waiting for API request.")
        
        let apiRequest = MVApiRequest(networkService: MVNetworkServiceSuccessMock())
        apiRequest.getCharacters(offset: 0, count: 10).asObservable().subscribe(onNext: { status in
            switch status {
            case .success(_):
                XCTAssert(true)
                expectation.fulfill()
            default:
                XCTFail()
                expectation.fulfill()
            }
        }).disposed(by: bag)
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testGetCharactersFail() {
        
        let expectation = XCTestExpectation(description: "Waiting for API request.")
        
        let apiRequest = MVApiRequest(networkService: MVNetworkServiceFailMock())
        apiRequest.getCharacters(offset: 0, count: 10).asObservable().subscribe(onNext: { status in
            switch status {
            case .error(_):
                XCTAssert(true)
                expectation.fulfill()
            default:
                XCTFail()
                expectation.fulfill()
            }
        }).disposed(by: bag)
        
        wait(for: [expectation], timeout: 1.0)
    }
}
