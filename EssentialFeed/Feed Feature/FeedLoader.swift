//
//  FeedLoader.swift
//  EssentialFeed
//
//  Created by Andy Hao on 2022/10/1.
//

import Foundation
enum LoadFeedResult {
    case success([FeedItem])
    case error(Error)
}

protocol FeedLoader {
    func laod(completion: @escaping (LoadFeedResult) -> Void)
}
