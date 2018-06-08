//
//  Area.swift
//  FansArea
//
//  Created by qujiahong on 2018/6/2.
//  Copyright © 2018年 瞿嘉洪. All rights reserved.
//

struct Area {
    ///name
    var name : String
    ///省份
    var province : String
    ///地区
    var part : String
    ///缩略图
    var thumbImage : String
    ///记录状态
    var visited : Bool
    
    ///新增评分字段
    var rating = ""
    
    
    init(name: String, province: String, part: String, thumbImage: String, visited: Bool) {
        self.name = name
        self.province = province
        self.part = part
        self.thumbImage = thumbImage
        self.visited = visited
    }
}

/*
 Area(name: "川1", province: "四川", part: "四川省资阳市安岳县", thumbImage: "baiyun", visited: false) ,
 Area(name: "川2", province: "四川", part: "四川省资阳市安岳县", thumbImage: "chengxi", visited: false) ,
 Area(name: "川3", province: "四川", part: "四川省资阳市安岳县", thumbImage: "furong", visited: false) ,
 Area(name: "重1", province: "重庆", part: "重庆巴南万达广场B区", thumbImage: "jinping", visited: false) ,
 Area(name: "重2", province: "重庆", part: "重庆解放碑", thumbImage: "nangang", visited: false) ,
 Area(name: "重3", province: "重庆", part: "重庆洪崖洞", thumbImage: "qilihe", visited: false) ,
 Area(name: "贵1", province: "贵", part: "3贵", thumbImage: "shangjie", visited: false) ,
 Area(name: "贵2", province: "贵", part: "2贵", thumbImage: "wuhou", visited: false) ,
 Area(name: "贵3", province: "贵", part: "贵", thumbImage: "xining", visited: false) ,
 Area(name: "贵4", province: "贵", part: "我不在贵州我不在贵州我不在贵州我不在贵州我不在贵州我不在贵州我不在贵州我不在贵州", thumbImage: "baiyun", visited: false) ,
 Area(name: "贵5", province: "贵", part: "我也不在贵州", thumbImage: "chengxi", visited: false)
 */
