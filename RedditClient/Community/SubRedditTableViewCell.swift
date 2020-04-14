//
//  SubRedditTableViewCell.swift
//  RedditClient
//
//  Created by erwin robles jr on 09/04/2020.
//  Copyright © 2020 sample organization. All rights reserved.
//

import UIKit

class SubRedditTableViewCell: UITableViewCell{
    
    @IBOutlet weak var logoImageView: CustomImageView!
    @IBOutlet weak var subRedditName: UILabel!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
    
    func configure(children: Children?){
        if let children = children{
            subRedditName.attributedText = NSMutableAttributedString()
                .normal("\(children.data?.namePrefix ?? "")")
            .bold("\(children.data?.display_name ?? "")", size: subRedditName.font.pointSize)
            logoImageView.image = UIImage(named: Defaults.default_icon)
            if let url = URL(string: children.data?.icon_img ?? ""){
                logoImageView.loadImage(with: url)
            }
            
        }
    }
    
}
