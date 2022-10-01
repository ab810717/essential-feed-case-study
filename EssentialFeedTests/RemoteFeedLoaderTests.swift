//
//  RemoteFeedLoaderTests.swift
//  EssentialFeedTests
//
//  Created by Andy Hao on 2022/10/1.
//

import XCTest

class RemoteFeedloader {
    let client: HTTPClient
    let url: URL
    init(url: URL, client: HTTPClient) {
        self.url = url
        self.client = client
    }
    
    func load() {
        client.get(from: url)
    }
}

protocol HTTPClient {
    func get(from url: URL)
}


class RemoteFeedLoaderTests: XCTestCase {
    
    func test_init_doesNotRequestDataFromURL() {
        let url =  URL(string: "https://a-url.com")!
        let (_, client) = makeSUT()
        _ = RemoteFeedloader(url: url, client: client)
        XCTAssertNil(client.requestedURL)
    }
    
    func test_load_requestDataFromURL() {
        let url =  URL(string: "https://a-given-url.com")!
        let (sut, client) = makeSUT(url: url)
        sut.load()
        XCTAssertEqual(client.requestedURL, url)
    }
    
    // MARK: - Helpers
    private func makeSUT(url:URL = URL(string: "https://a-url.com")!) -> (sut:RemoteFeedloader, client: HTTPClientSpy) {
        let client = HTTPClientSpy()
        let sut = RemoteFeedloader(url: url, client: client)
        return (sut,client)
    }
    
    private class HTTPClientSpy: HTTPClient {
        var requestedURL: URL?
        func get(from url: URL) {
            requestedURL = url
        }

    }
}

