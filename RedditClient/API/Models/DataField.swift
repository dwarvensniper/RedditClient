//
//  DataField.swift
//  RedditClient
//
//  Created by erwin robles jr on 11/04/2020.
//  Copyright © 2020 sample organization. All rights reserved.
//

struct DataField: Decodable {
    let children: [Children]?
    let display_name: String?
    let display_name_prefixed: String?
    let icon_img: String?
    let url: String?
    
    var namePrefix: String{
        let range = display_name_prefixed?.range(of: display_name ?? "")
        var display_name_prefixed = self.display_name_prefixed
        if let range = range{
            display_name_prefixed?.removeSubrange(range)
        }
        return display_name_prefixed ?? ""
    }
    
    
}
