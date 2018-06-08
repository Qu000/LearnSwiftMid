//
//  ContentViewController.swift
//  FansArea
//
//  Created by qujiahong on 2018/6/7.
//  Copyright © 2018年 瞿嘉洪. All rights reserved.
//

import UIKit

class ContentViewController: UIViewController {
   
    @IBOutlet weak var labelHeading: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var labelFooter: UILabel!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var btnDone: UIButton!
    
    var index = 0//当前VC的索引
    var heading = ""
    var footer = ""
    var imageName = ""
    
    @IBAction func btnDoneTap(_ sender: UIButton) {
        
        //以guiderShow为关键字，存入
        let defaults = UserDefaults.standard
        defaults.set(true, forKey: "guiderShow")
        
        self.dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        labelHeading.text = heading
        labelFooter.text = footer
        imageView.image = UIImage(named: imageName)

        pageControl.currentPage = index
        //只要不是最后一页，按钮就一直隐藏
        btnDone.isHidden = (index != 2)
    }


}
