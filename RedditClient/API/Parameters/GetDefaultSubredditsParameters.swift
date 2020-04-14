//
//  GetDefaultSubredditsParameters.swift
//  RedditClient
//
//  Created by erwin robles jr on 11/04/2020.
//  Copyright © 2020 sample organization. All rights reserved.
//

struct GetDefaultSubredditsParameters: Parameter{
    
    var limit: Int?
    var sort: String?
    var sr_detail: Bool?
    
    init() {
        limit = Defaults.limit
    }
}
