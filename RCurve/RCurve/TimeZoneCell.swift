//
//  TimeZoneCell.swift
//  RCurve
//
//  Created by Sandeep Joshi on 1/29/19.
//  Copyright © 2019 Sandeep Joshi. All rights reserved.
//

import UIKit

class TimeZoneCell: UICollectionViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        
        layer.shadowColor = UIColor.lightGray.cgColor
        layer.shadowRadius = 12.0
        layer.shadowOpacity = 0.7
        layer.shadowOffset = CGSize.zero
        layer.cornerRadius = 20.0
    }

}
