//
//  Dictionary+Ext.swift
//  RedditClient
//
//  Created by erwin robles jr on 12/04/2020.
//  Copyright © 2020 sample organization. All rights reserved.
//

import UIKit

extension Dictionary where Key == String, Value == [Children]{
    
    func getTitles() -> [String]{
        return [String](keys).sorted(by: {$0.lowercased() < $1.lowercased()})
    }
    
}
