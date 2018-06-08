//
//  WebViewController.swift
//  FansArea
//
//  Created by qujiahong on 2018/6/8.
//  Copyright © 2018年 瞿嘉洪. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController {

    @IBOutlet weak var webView: UIWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webView.isHidden = true
        
        
        let wkWebView = WKWebView(frame: view.frame)
        wkWebView.autoresizingMask = [.flexibleHeight]
        view.addSubview(wkWebView)
        if let url = URL(string: "https://www.jianshu.com/u/21c35a95919e") {
            let request = URLRequest(url: url)
//            webView.loadRequest(request)
            wkWebView.load(request)
        }
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
