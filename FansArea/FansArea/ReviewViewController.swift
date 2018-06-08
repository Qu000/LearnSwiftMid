//
//  ReviewViewController.swift
//  FansArea
//
//  Created by qujiahong on 2018/6/5.
//  Copyright © 2018年 瞿嘉洪. All rights reserved.
//

import UIKit



class ReviewViewController: UIViewController {

    @IBOutlet weak var BgImage: UIImageView!
    @IBOutlet weak var RatingStackView: UIStackView!
    var imageData : Data!
    
    ///闭包传值
    //声明闭包
    typealias RatingCloser = (String) -> Void
    
    //定义闭包变量
    var ratingCloser : RatingCloser?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        BgImage.image = UIImage(data: imageData)
        let blurEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .light))
        blurEffectView.frame = view.frame
        BgImage.addSubview(blurEffectView)
        
        //起始位置：屏幕上面500个点
        let startPos = CGAffineTransform(translationX: 0, y: 500)
        let startScale = CGAffineTransform(scaleX: 0, y: 0)
        RatingStackView.transform = startScale.concatenating(startPos)
    }

    override func viewDidAppear(_ animated: Bool) {

        UIView.animate(withDuration: 0.8, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: [], animations: {
            
            let endPos = CGAffineTransform(translationX: 0, y: 0)
            let endScale = CGAffineTransform.identity
            self.RatingStackView.transform = endPos.concatenating(endScale)

        }, completion: nil)
    }
    
    @IBAction func clickToBack(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func clickToRating(_ sender: UIButton) {
       
        switch sender.tag {
        case 0:
            if ratingCloser != nil {
                self.ratingCloser!("dislike")
            }
            
        case 1:

            if ratingCloser != nil {
                self.ratingCloser!("good")
            }
            
        case 2:

            if (ratingCloser != nil) {
                self.ratingCloser!("great")
            }
        default:
            break
        }
        self.dismiss(animated: true, completion: nil)
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
