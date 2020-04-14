//
//  SubReddit.swift
//  RedditClient
//
//  Created by erwin robles jr on 11/04/2020.
//  Copyright © 2020 sample organization. All rights reserved.
//

struct SubReddit: Decodable {
    let kind: String?
    let data: DataField?
    
    var subredditDictionary: Dictionary<String, [Children]>{
        var dictionary = [String:[Children]]()
        for children in data?.children ?? []{
            let key = String(children.data?.display_name?.prefix(1).uppercased() ?? "")
            if var values = dictionary[key]{
                values.append(children)
                dictionary[key] = values
            } else {
                dictionary[key] = [children]
            }
        }
        return dictionary
    }
}
