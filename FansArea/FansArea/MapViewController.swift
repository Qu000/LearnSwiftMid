//
//  MapViewController.swift
//  FansArea
//
//  Created by qujiahong on 2018/6/6.
//  Copyright © 2018年 瞿嘉洪. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController,MKMapViewDelegate {

    @IBOutlet weak var mapView: MKMapView!
    var area : AreaMO!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "地图详情"
        
        mapView.delegate = self
        
        let geocoder = CLGeocoder()
        //如果地址(地名)可以转换，返回结果中包含两个参数：地标列表&错误信息
        geocoder.geocodeAddressString(area.part!) { (ps, error) in
            //gaurd方法确保地标存在，否则退出并心事错误信息
            guard let ps = ps else{
                print(error ?? "未知错误")
                return
            }
            
            //取地标数组第一个(最接近的一个)
            let place = ps.first
            //实例化标注，设置标题和副标题
            let annotation = MKPointAnnotation()
            annotation.title = self.area.province
            annotation.subtitle = self.area.part
            
            //如果地址坐标存在，则设置标注的坐标为地址坐标
            if let loc = place?.location{
                annotation.coordinate = loc.coordinate
                //让mapView显示标注，并选中其中一个(这里只有一个)
                self.mapView.showAnnotations([annotation], animated: true)
                self.mapView.selectAnnotation(annotation, animated: true)
            }
            
        }
        
    }

    // MARK: - MKMapKitDelegate
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {

        //如果用户 位置视图也是一个标注视图，就排除自定义[显示自己位置，不用标注]
        if annotation is MKUserLocation {
            return nil
        }

        //为了性能考虑，重用一个已经存在的标注视图
        let id = "myAnnotationId"
        var av = mapView.dequeueReusableAnnotationView(withIdentifier: id) as? MKPinAnnotationView

        //无重用的 就初始化一个带📌的标注，并启用气球提示
        if av == nil {
            av = MKPinAnnotationView(annotation: annotation, reuseIdentifier: id)
            av?.canShowCallout = true
        }

        //添加一个地区缩略图到标注视图中
        let leftIconView = UIImageView(frame: CGRect(x: 0, y: 0, width: 53, height: 53))
        leftIconView.image = UIImage(data: area.thumbImage as! Data)
        av?.leftCalloutAccessoryView = leftIconView

        return av
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
