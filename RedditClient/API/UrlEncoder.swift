//
//  UrlEncoder.swift
//  RedditClient
//
//  Created by erwin robles jr on 11/04/2020.
//  Copyright © 2020 sample organization. All rights reserved.
//
import Foundation

class UrlEncoder{
    
    func getFullUrl(subUrl: SubUrl?, urlType: UrlType?, parameter: Parameter?) -> URL?{
        var url = ""
        if let subUrl = subUrl{
            url.append("/\(subUrl)")
        }
        if let urlType = urlType{
            url.append("/\(urlType.urlTypeString)")
        }
        if let parameter = parameter{
            let mirror = Mirror(reflecting: parameter)
            for (index, children) in mirror.children.enumerated() {
                if case Optional<Any>.none = children.value {
                    
                } else {
                    if let label = children.label{
                        if index == 0{
                            url.append("?")
                        }else{
                            url.append("&")
                        }
                    guard let result = self.unwrap(children.value) else { continue }
                    url.append("\(label)=\(result)")
                    }
                }
                
            }
        }
        return URL(string: "\(Defaults.baseUrl)\(url)")
    }
    
    private func unwrap(_ subject: Any) -> Any? {
        var value: Any?
        let mirrored = Mirror(reflecting:subject)
        if mirrored.displayStyle != .optional {
            value = subject
        } else if let firstChild = mirrored.children.first {
            value = firstChild.value
        }
        return value
    }
    
}
