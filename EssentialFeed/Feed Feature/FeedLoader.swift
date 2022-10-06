//
//  FeedLoader.swift
//  EssentialFeed
//
//  Created by Andy Hao on 2022/10/1.
//

import Foundation

public enum LoadFeedResult {
    case success([FeedItem])
    case failure(Error)
}

protocol FeedLoader {
    func load(completion: @escaping (LoadFeedResult) -> Void)
}
