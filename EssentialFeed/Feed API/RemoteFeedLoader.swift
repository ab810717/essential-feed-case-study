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
    public init(url: URL, client: HTTPClient) {
        self.url = url
        self.client = client
    }
    
    public func load() {
        client.get(from: url)
    }
}

public protocol HTTPClient {
    func get(from url: URL)
}
