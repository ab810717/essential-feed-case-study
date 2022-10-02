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
        sut.load{ _ in}
        XCTAssertEqual(client.requestedURLs, [url])
    }
    
    func test_laod_requestsDataFromURLTwice() {
        let url =  URL(string: "https://a-given-url.com")!
        let (sut, client) = makeSUT(url: url)
        sut.load{ _ in }
        sut.load{ _ in }
        XCTAssertEqual(client.requestedURLs, [url,url])
    }
    
    func test_load_deliversErrorOnClientError() {
        let (sut, clinet) = makeSUT()
    
        var capturedErrors = [RemoteFeedloader.Error]()
        sut.load { capturedErrors.append($0) }
        
        let clientError = NSError(domain: "Test", code: 0)
        clinet.complete(with: clientError)
        
        XCTAssertEqual(capturedErrors, [.connetivity])
    }
    
    func test_load_deliversErrorOnNon200HTTPResponse() {
        let (sut, clinet) = makeSUT()
        
        let samples = [199, 201, 300, 400, 500]
        
        samples.enumerated().forEach{ index, code in
            var capturedErrors = [RemoteFeedloader.Error]()
            sut.load { capturedErrors.append($0) }
            clinet.complete(withStatusCode: code, at: index)
            XCTAssertEqual(capturedErrors, [.invalidData])
        }
    }
    
    // MARK: - Helpers
    private func makeSUT(url:URL = URL(string: "https://a-url.com")!) -> (sut:RemoteFeedloader, client: HTTPClientSpy) {
        let client = HTTPClientSpy()
        let sut = RemoteFeedloader(url: url, client: client)
        return (sut,client)
    }
    
    private class HTTPClientSpy: HTTPClient {
        var requestedURLs: [URL] {
            return message.map {$0.url}
        }
        
        private var message = [(url: URL, completion: (HTTPClientResult) -> Void)]()
        
        func get(from url: URL, completion: @escaping (HTTPClientResult) -> Void) {
            message.append((url, completion))
        }
        
        func complete(with error: Error, at index: Int = 0) {
            message[index].completion(.failure(error))
        }
        
        func complete(withStatusCode code: Int, at index: Int = 0) {
            let response = HTTPURLResponse(
                url: requestedURLs[index],
                statusCode: code,
                httpVersion: nil,
                headerFields: nil
            )!
            message[index].completion(.succses(response))
        }
        
    }
}

