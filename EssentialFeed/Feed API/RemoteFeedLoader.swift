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
    
    public init(url: URL, client: HTTPClient) {
        self.url = url
        self.client = client
    }
    
    public func load(completion: @escaping (Error) -> Void) {
        client.get(from: url) { result  in
            switch result {
            case .succses:
                completion(.invalidData)
            case .failure:
                completion(.connetivity)
            }
            
        }
    }
}
