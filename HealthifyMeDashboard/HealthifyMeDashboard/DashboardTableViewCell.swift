//
//  DashboardTableViewCell.swift
//  HealthifyMeDashboard
//
//  Created by Dhwani Thaker on 3/18/16.
//  Copyright © 2016 Dhwani Thaker. All rights reserved.
//

import UIKit

class DashboardTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var expandedLabel: UILabel!
    
    class var expandedHeight : CGFloat { get { return 200 } }
    class var defaultHeight : CGFloat { get { return 44 } }
    
    func checkHeight()
    {
        expandedLabel.hidden = (frame.size.height < DashboardTableViewCell.expandedHeight)
    }
}
