//
//  APIManager.swift
//  RedditClient
//
//  Created by erwin robles jr on 10/04/2020.
//  Copyright © 2020 sample organization. All rights reserved.
//

import UIKit

protocol APIManagerDelegate {
    func onGetDefaultSubredditsSuccess(subreddit: SubReddit)
    func onGetDefaultSubredditsFailed(errorString: String)
}

extension APIManagerDelegate{
    func onGetDefaultSubredditsSuccess(subreddit: SubReddit){}
    func onGetDefaultSubredditsFailed(errorString: String){}
}

class APIManager{
    
    var apiRequest: ApiRequest?
    var delegate: APIManagerDelegate?
    
    init() {
        apiRequest = ApiRequest()
    }
    
    func getDefaultSubreddits(getDefaultSubredditsParameters: GetDefaultSubredditsParameters){
        apiRequest?.send(request: GetDefaultSubredditsRequest(parameter: getDefaultSubredditsParameters), completion: { (response) in
            switch(response){
            case .success(let subreddit):
                if let subreddit = subreddit{
                    self.delegate?.onGetDefaultSubredditsSuccess(subreddit: subreddit)
                }else{
                    self.delegate?.onGetDefaultSubredditsFailed(errorString: "No Data!")
                }
                break;
            case .failure(let error):
                self.delegate?.onGetDefaultSubredditsFailed(errorString: error)
                break;
            case .responseError(let responseError):
                self.delegate?.onGetDefaultSubredditsFailed(errorString: responseError.message ?? "")
            }
        })
    }
    
}
