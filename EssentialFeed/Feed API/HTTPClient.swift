//
//  HTTPClient.swift
//  EssentialFeed
//
//  Created by Andy Hao on 2022/10/6.
//

import Foundation

public enum HTTPClientResult {
    case succses(Data, HTTPURLResponse)
    case failure(Error)
}

public protocol HTTPClient {
    func get(from url: URL, completion: @escaping (HTTPClientResult) -> Void)
}
