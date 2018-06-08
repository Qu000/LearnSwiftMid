//
//  GuiderViewController.swift
//  FansArea
//
//  Created by qujiahong on 2018/6/7.
//  Copyright © 2018年 瞿嘉洪. All rights reserved.
//

import UIKit

class GuiderViewController: UIPageViewController,UIPageViewControllerDataSource {

    var headings = ["Swift","iOS","零基础？"]
    var images = ["swift","iOS","beginner"]
    var footers = ["Swift 其实不难的呀，兄弟，用起来超爽！","iOS 也很好呀，毕竟是靠着它要发家致富的！","无需预备知识呀，新手也可以玩转的！"]
    
    
    
    
    //MARK: - UIPageViewControllerDataSource
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        var index = (viewController as! ContentViewController).index
        
        index -= 1
        
        return vc(atIndex: index)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        var index = (viewController as! ContentViewController).index
        
        index += 1
        
        return vc(atIndex: index)
    }
    
    func vc(atIndex: Int) -> ContentViewController? {
        //判断index是否在合理的区间内，用Swift的if case语句
        if case 0..<headings.count = atIndex {
            if let contentVC = storyboard?.instantiateViewController(withIdentifier: "ContentViewController") as? ContentViewController{
                contentVC.heading = headings[atIndex]
                contentVC.footer = footers[atIndex]
                contentVC.imageName = images[atIndex]
                contentVC.index = atIndex
                
                return contentVC
            }
        }
        return nil
    }
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource = self
        
        if let startVC = vc(atIndex: 0) {
            setViewControllers([startVC], direction: .forward, animated: true, completion: nil)
        }


    }

    // MARK: - 添加页码
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return headings.count
    }
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return 0
    }
    

}
