//
//  CaloriesEatenTableViewCell.swift
//  HealthifyMeDashboard
//
//  Created by Dhwani Thaker on 3/20/16.
//  Copyright © 2016 Dhwani Thaker. All rights reserved.
//

import UIKit

protocol CaloriesEatenTableViewCellDelegate
{
    func cellTapped(cell : CaloriesEatenTableViewCell)
}

class CaloriesEatenTableViewCell: UITableViewCell, UIScrollViewDelegate {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    @IBOutlet weak var expandedButtonOutlet: UpDownButton!
    
    @IBOutlet weak var ibImageView: UIImageView!
    
    let screenSize = UIScreen.mainScreen().bounds.size
    
    var caloriesEatenTableViewCellDelegate : CaloriesEatenTableViewCellDelegate!
    
    var pageViews : [UIView?] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
        
        displayNib()
        scrollView.delegate = self
        pageControl.currentPage = 0
        pageControl.numberOfPages = pageViews.count
        
        scrollView.bounds.size.width = screenSize.width
        let pagesScrollViewSize = scrollView.frame.size
        scrollView.contentSize = CGSize(width: pagesScrollViewSize.width * CGFloat(pageViews.count), height: pagesScrollViewSize.height)
        pageControl.currentPageIndicatorTintColor = UIColor.whiteColor()
        pageControl.pageIndicatorTintColor = UIColor.blackColor()
        loadPages()
        
        self.ibImageView.image = UIImage(named: "fork&knife")

    }
    
    func displayNib()
    {
        for i in 1...2
        {
            let displayView = UINib(nibName: "CalEatenDisplayView\(i)", bundle: nil).instantiateWithOwner(self, options: nil)[0] as! UIView
            pageViews.append(displayView)
            
        }
    }
    
    func loadPage(page:Int)
    {
        if page < 0 || page >= pageViews.count
        {
            return
        }
        
        var frame = self.scrollView.bounds
        frame.origin.x = (frame.size.width * CGFloat(page)) + 5.0
        frame.origin.y = 15.0
        
        let newPageView = pageViews[page]
        newPageView!.contentMode = .ScaleAspectFit
        newPageView!.frame = frame
        scrollView.addSubview(newPageView!)
        
        pageViews[page] = newPageView
        
    }
    
    func loadPages()
    {
        let pageWidth = self.scrollView.frame.size.width
        let page = Int(floor(scrollView.contentOffset.x * 2.0 + pageWidth) / (pageWidth * 2.0))
        
        pageControl.currentPage = page
        
        let firstPage = page - 1
        let lastPage = page + 1
        
        for var i = 0; i < firstPage; i++
        {
           returnPage(i)
        }
        
        for i in firstPage...lastPage
        {
            loadPage(i)
        }
        
        for var i = lastPage + 1; i < pageViews.count; i++
        {
            returnPage(i)
        }
    }
    
    func returnPage(page:Int)
    {
        if page < 0 || page >= pageViews.count
        {
            return
        }
        if let pageView = pageViews[page]
        {
            pageView.removeFromSuperview()
            pageViews[page] = nil
        }
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
       // displayNib()
        loadPages()
    }
    
    @IBAction func expandButtonTapped(sender: AnyObject) {
        if let delegate = caloriesEatenTableViewCellDelegate
        {
            delegate.cellTapped(self)
        }
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
