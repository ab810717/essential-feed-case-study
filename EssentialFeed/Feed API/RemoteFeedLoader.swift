//
//  RemoteFeedLoader.swift
//  EssentialFeed
//
//  Created by Andy Hao on 2022/10/2.
//

import Foundation

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
                completion(FeedItemsMapper.map(data, from: response))
                
            case .failure:
                completion(.failure(.connetivity))
            }
            
        }
    }
    
}




