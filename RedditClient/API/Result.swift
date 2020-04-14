//
//  Result.swift
//  RedditClient
//
//  Created by erwin robles jr on 11/04/2020.
//  Copyright © 2020 sample organization. All rights reserved.
//

import Foundation

enum Result<Value> {
    case success(Value?)
    case failure(String)
    case responseError(ErrorResponse)
}

typealias ResultCallback<Value> = (Result<Value>) -> Void
