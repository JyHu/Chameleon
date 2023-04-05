//
//  File.swift
//  
//
//  Created by Jo on 2023/4/2.
//

import Foundation

enum APPError: Error {
    /// 解析换肤属性索引错误
    ///  - 当前换肤数据的key
    ///  - 当前遍历到的索引
    case parseIndexError(String, Int)
    
    /// 根据换肤标识获取对应的换肤属性的时候失败，找不到有效的字典数据
    case unknownAppearanceInfo(Any)
    
    /// 解析换肤文件中图片资源的时候遇到未知的图片数据
    case unknowImageAppearance(Any)
}
