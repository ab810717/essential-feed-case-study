//
//  RemoteFeedLoaderTests.swift
//  EssentialFeedTests
//
//  Created by Andy Hao on 2022/10/1.
//

import XCTest

class Remoteloader {
    
}

class HTTPClient {
    var requestURL: URL?
}

class RemoteFeedLoaderTests: XCTestCase {
    func test_init_doesNotRequestDataFromURL() {
        let client = HTTPClient()
        _ = Remoteloader()
        XCTAssertNil(client.requestURL)
    }
}
