//
//  GetDefaultSubredditsRequest.swift
//  RedditClient
//
//  Created by erwin robles jr on 11/04/2020.
//  Copyright © 2020 sample organization. All rights reserved.
//

class GetDefaultSubredditsRequest: Request{
    
    typealias Response = SubReddit
    var queryParameters: Parameter?
    var bodyParameters: Parameter?
    
    var urlType: UrlType?{
        return.default
    }
    
    var subUrl: SubUrl?{
        return .subreddits
    }
    
    var httpMethods: HttpMethod?{
        return .GET
    }
    
    init(parameter: GetDefaultSubredditsParameters) {
        queryParameters = parameter
    }
}
