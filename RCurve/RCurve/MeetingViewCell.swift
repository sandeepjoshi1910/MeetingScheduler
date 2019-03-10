//
//  MeetingViewCell.swift
//  RCurve
//
//  Created by Sandeep Joshi on 9/30/18.
//  Copyright © 2018 Sandeep Joshi. All rights reserved.
//

import UIKit

class MeetingViewCell: UICollectionViewCell {
    
    @IBOutlet weak var closeBtn: UIButton!
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        layer.shadowColor = UIColor.lightGray.cgColor
        layer.shadowRadius = 12.0
        layer.shadowOpacity = 0.7
        layer.shadowOffset = CGSize.zero
        layer.cornerRadius = 20.0
    }
    @IBAction func close(_ sender: Any) {
        print("Close clicked")
    }
    
    
}
