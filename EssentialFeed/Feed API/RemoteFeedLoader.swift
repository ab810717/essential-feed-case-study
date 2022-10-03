//
//  RemoteFeedLoader.swift
//  EssentialFeed
//
//  Created by Andy Hao on 2022/10/2.
//

import Foundation
public enum HTTPClientResult {
    case succses(Data, HTTPURLResponse)
    case failure(Error)
}

public protocol HTTPClient {
    func get(from url: URL, completion: @escaping (HTTPClientResult) -> Void)
}

public class RemoteFeedloader {
    private let url: URL
    private let client: HTTPClient
    
    public enum Error: Swift.Error {
        case connetivity
        case invalidData
    }
    
    public enum Result: Equatable {
        case succcess([FeedItem])
        case failure(Error)
    }

    
    public init(url: URL, client: HTTPClient) {
        self.url = url
        self.client = client
    }
    
    public func load(completion: @escaping (Result) -> Void) {
        client.get(from: url) { result  in
            switch result {
            case let .succses(data, response):
                if response.statusCode == 200, let root = try? JSONDecoder().decode(Root.self, from: data) {
                    completion(.succcess(root.items))
                } else {
                    completion(.failure(.invalidData))
                }
                
            case .failure:
                completion(.failure(.connetivity))
            }
            
        }
    }
}

private struct Root: Decodable {
    let items: [FeedItem]
}
