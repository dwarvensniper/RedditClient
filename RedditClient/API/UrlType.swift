//
//  UrlType.swift
//  RedditClient
//
//  Created by erwin robles jr on 11/04/2020.
//  Copyright © 2020 sample organization. All rights reserved.
//

enum UrlType{
    case `default`
    
    var urlTypeString: String{
        switch self {
        case .default:
            return "default.json"
        }
    }
}
