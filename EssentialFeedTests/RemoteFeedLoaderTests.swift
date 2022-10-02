//
//  RemoteFeedLoaderTests.swift
//  EssentialFeedTests
//
//  Created by Andy Hao on 2022/10/1.
//

import XCTest
import EssentialFeed

class RemoteFeedLoaderTests: XCTestCase {
    
    func test_init_doesNotRequestDataFromURL() {
        let url =  URL(string: "https://a-url.com")!
        let (_, client) = makeSUT()
        _ = RemoteFeedloader(url: url, client: client)
        XCTAssertTrue(client.requestedURLs.isEmpty)
    }
    
    func test_load_requestsDataFromURL() {
        let url =  URL(string: "https://a-given-url.com")!
        let (sut, client) = makeSUT(url: url)
        sut.load()
        XCTAssertEqual(client.requestedURLs, [url])
    }
    
    func test_laod_requestsDataFromURLTwice() {
        let url =  URL(string: "https://a-given-url.com")!
        let (sut, client) = makeSUT(url: url)
        sut.load()
        sut.load()
        XCTAssertEqual(client.requestedURLs, [url,url])
    }
    
    func test_load_deliversErrorOnClientError() {
        let (sut, clinet) = makeSUT()
        clinet.error = NSError(domain: "Test", code: 0)
        
        var capturedErrors = [RemoteFeedloader.Error]()
        sut.load { capturedErrors.append($0) }
        
        XCTAssertEqual(capturedErrors, [.connetivity])
    }
    
    // MARK: - Helpers
    private func makeSUT(url:URL = URL(string: "https://a-url.com")!) -> (sut:RemoteFeedloader, client: HTTPClientSpy) {
        let client = HTTPClientSpy()
        let sut = RemoteFeedloader(url: url, client: client)
        return (sut,client)
    }
    
    private class HTTPClientSpy: HTTPClient {
        var requestedURLs = [URL]()
        var error: Error?

        func get(from url: URL, completion: @escaping (Error) -> Void) {
            if let error = error {
                completion(error)
            }
            requestedURLs.append(url)
        }

    }
}

