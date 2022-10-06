//
//  FeedLoader.swift
//  EssentialFeed
//
//  Created by Andy Hao on 2022/10/1.
//

import Foundation

public enum LoadFeedResult<Error: Swift.Error> {
    case success([FeedItem])
    case failure(Error)
}

extension LoadFeedResult: Equatable where Error:Equatable{}

protocol FeedLoader {
    associatedtype Error: Swift.Error
    func laod(completion: @escaping (LoadFeedResult<Error>) -> Void)
}
