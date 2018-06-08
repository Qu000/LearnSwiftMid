//
//  AddAreaTableViewController.swift
//  FansArea
//
//  Created by qujiahong on 2018/6/6.
//  Copyright © 2018年 瞿嘉洪. All rights reserved.
//

import UIKit
import CoreData

class AddAreaTableViewController: UITableViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    @IBOutlet weak var coverImageView: UIImageView!
    
    @IBOutlet weak var tfName: UITextField!
    @IBOutlet weak var tfProvince: UITextField!
    @IBOutlet weak var tfPart: UITextField!
    @IBOutlet weak var labelVisited: UILabel!
    
    
    var area: AreaMO!
    var isVisited = false
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

    @IBAction func saveTap(_ sender: UIBarButtonItem) {
        
        //获取appDelegate
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        //Core Data持久化容器中的context
        area = AreaMO(context: appDelegate.persistentContainer.viewContext)
        area.name = tfName.text
        area.province = tfProvince.text
        area.part = tfPart.text
        area.visited = isVisited
        
        //图片转为 JPG格式
        if let imageData = UIImageJPEGRepresentation(coverImageView.image!, 0.7) {
            area.thumbImage = NSData(data: imageData) as Data
        }
        
        //保存并返回首页
        print("正在保存")
        appDelegate.saveContext()
        performSegue(withIdentifier: "unwindToHomeList", sender: self)
    }
    @IBAction func isVisitedBtnTap(_ sender: UIButton) {
        if sender.tag == 1 {
            isVisited = true
            labelVisited.text = "我来过"
        }else{
            isVisited = false
            labelVisited.text = "我没去过呀"
        }
    }
    
    // MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //检测相册访问权限
        //info.plist里开启Photo、Camera的权限
        if indexPath.row == 0 {
            guard UIImagePickerController.isSourceTypeAvailable(.photoLibrary) else { return }
            
            //实例化一个UIImagePickerController对象
            //属性是：不允许编辑，来源为相册，以模态视图弹出
            let picker = UIImagePickerController()
            picker.allowsEditing = false
            picker.sourceType = .photoLibrary
            
            //只有实现了代理，才可实现代理的方法
            picker.delegate = self
            self.present(picker, animated: true, completion: nil)
            
        }
        tableView.deselectRow(at: indexPath, animated: true)
      
        switch indexPath.row {
        //检测相册访问权限
        case 0:
            print("图")
        case 1:
            print("地名")
        case 2:
            print("省份")
        case 3:
            print("区县")
        case 4:
            print("是or否")
        default:
            break
        }
    }
    
    //当用户从相册选择一张图后，会触发方法，可从方法的参数中取回图片
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        //从info字典中，查询"原始图像"
        coverImageView.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        //平铺、裁边
        coverImageView.contentMode = .scaleAspectFill
        coverImageView.clipsToBounds = true
        
        let coverWidthCons = NSLayoutConstraint(item: coverImageView, attribute: .width, relatedBy: .equal, toItem: coverImageView.superview, attribute: .width, multiplier: 1, constant: 0)
        let coverHeightCons = NSLayoutConstraint(item: coverImageView, attribute: .height, relatedBy: .equal, toItem: coverImageView.superview, attribute: .height, multiplier: 1, constant: 0)
        coverWidthCons.isActive = true
        coverHeightCons.isActive = true
        
        
        //视图自退场
        dismiss(animated: true, completion: nil)
    }
    // MARK: - Table view data source


}
