//
//  Request.swift
//  RedditClient
//
//  Created by erwin robles jr on 11/04/2020.
//  Copyright © 2020 sample organization. All rights reserved.
//

protocol Request{
    associatedtype Response: Decodable
    var httpMethods: HttpMethod? { get }
    var subUrl: SubUrl? { get }
    var urlType: UrlType? { get }
    var queryParameters: Parameter? { get set }
    var bodyParameters: Parameter? { get set }
}
