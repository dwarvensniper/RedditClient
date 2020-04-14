//
//  File.swift
//  RedditClient
//
//  Created by erwin robles jr on 12/04/2020.
//  Copyright © 2020 sample organization. All rights reserved.
//

import UIKit

extension NSMutableAttributedString{
    func bold(_ value:String, size: CGFloat) -> NSMutableAttributedString {

        let attributes:[NSAttributedString.Key : Any] = [
            .font : UIFont.boldSystemFont(ofSize: size)
        ]

        self.append(NSAttributedString(string: value, attributes:attributes))
        return self
    }
    
    func normal(_ value:String) -> NSMutableAttributedString {
        self.append(NSAttributedString(string: value))
        return self
    }
}
