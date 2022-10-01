//
//  RemoteFeedLoaderTests.swift
//  EssentialFeedTests
//
//  Created by Andy Hao on 2022/10/1.
//

import XCTest

class Remoteloader {
    let client: HTTPClient
    init(client: HTTPClient) {
        self.client = client
    }
    func load() {
        client.get(from: URL(string: "https://a-url.com")!)
    }
}

protocol HTTPClient {
    func get(from url: URL)
}

class HTTPClientSpy: HTTPClient {
    var requestedURL: URL?
    func get(from url: URL) {
        requestedURL = url
    }

}

class RemoteFeedLoaderTests: XCTestCase {
    func test_init_doesNotRequestDataFromURL() {
        let client = HTTPClientSpy()
        _ = Remoteloader(client: client )
        XCTAssertNil(client.requestedURL)
    }
    
    func test_load_requestDataFromURL() {
        let client = HTTPClientSpy()
        let sut = Remoteloader(client: client)
        sut.load()
        XCTAssertNotNil(client.requestedURL)
    }
}

