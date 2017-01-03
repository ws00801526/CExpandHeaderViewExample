//
//  XMNExpander.swift
//  XMNBanTangHomeDemo
//
//  Created by XMFraker on 16/12/30.
//  Copyright © 2016年 XMFraker. All rights reserved.
//

import UIKit
import Foundation


class XMNExpandedItem: NSObject {
    
    var scrollView: UIScrollView
    var headerView: UIView
    var originHeight: CGFloat = 0.0
    var maxHeight: CGFloat = CGFloat(Int.max)
    var minHeight: CGFloat = 0.0

    init(scrollView: UIScrollView, headerView: UIView) {
        
        self.scrollView = scrollView
        self.headerView = headerView
        super.init()

        if self.scrollView.subviews.contains(headerView) {
            
            //如果headerView已经在scrollView上了, 更改headerView.frame  scrollView.contentInset
            self.originHeight = headerView.bounds.size.height
            self.scrollView.contentInset = UIEdgeInsetsMake(self.originHeight, 0, 0, 0)
        }else {
            
            //如果headerView不在scrollView上, 更改scrollView.contentOffset, 保证headerView 默认展示
            self.originHeight = max(min(self.headerView.frame.maxY, self.maxHeight), self.minHeight)
            self.scrollView.scrollIndicatorInsets = UIEdgeInsetsMake(self.originHeight, 0, 0, 0)
        }
        
        //配置headerView
        self.headerView.contentMode = .scaleAspectFill
        self.headerView.clipsToBounds = true
        
        //添加scrollView.contentOffset事件监听
        self.scrollView.addObserver(self, forKeyPath: "contentOffset", options: [.new,.initial], context: nil)
    }

    /// 重写obserValue方法
    /// 忽略不是contentOffset的时间
    /// - Parameters:
    ///   - keyPath:  需要监听的keyPath
    ///   - object:   对应的监听对象object
    ///   - change:   事件变化类型
    ///   - context:  上下文
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        if keyPath == "contentOffset" {
        
            self.resizeHeaderView()
            return
        }
        
        if keyPath == "alpha" {
            let imageView = object as! UIImageView
            print("view change alpha \(imageView)")
            return;
        }
        
        super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)
    }
    
    /// scrollView滚动时 ,重新配置headerView.frame
    func resizeHeaderView() {
        
        //获取当前的contentOffset
        let offsetY = self.scrollView.contentOffset.y
        if !self.scrollView.subviews.contains(self.headerView) {

            //向上滚动时  offset 增大,  保证headerView放大大小不大于  maxHeight
            //向下滚动时  offset <= 0   保证headerView的大小不小于    minHeight
            let height = offsetY <= 0 ? min(self.maxHeight, abs(offsetY) + self.originHeight) : max(self.minHeight, self.originHeight - offsetY)
            self.headerView.frame = CGRect(x: self.headerView.frame.minX, y: self.headerView.frame.minY, width: self.headerView.frame.size.width, height: height)
            self.scrollView.scrollIndicatorInsets = UIEdgeInsetsMake(self.headerView.frame.maxY, 0, 0, 0)
        }else {

            if offsetY >= -self.minHeight {
                
                //向上滚动时 固定个尺寸
                self.headerView.frame = CGRect(x: 0, y: offsetY, width: self.headerView.frame.size.width, height: self.minHeight)
            }else if offsetY < -self.originHeight {
                
                //重新设置frame
                var frame = self.headerView.frame
                frame.origin.y = offsetY
                //增加frame最大值配置
                frame.size.height = max(min(abs(offsetY), self.maxHeight), self.minHeight)
                self.headerView.frame = frame
            }else {
                self.headerView.frame = CGRect(x: 0, y: offsetY, width: self.headerView.frame.size.width, height: abs(offsetY))
            }
            //调整scrollIndicatorInset
            self.scrollView.scrollIndicatorInsets = UIEdgeInsetsMake(self.headerView.frame.height, 0, 0, 0)
        }
    }
    
    deinit {

        print("item with scrollview \(self.scrollView) \n headerView \(self.headerView) \n deinit")
        //移除contentOffset 监听
        self.scrollView.removeObserver(self, forKeyPath: "contentOffset")
    }
}

class XMNExpander: NSObject, UIScrollViewDelegate {

    static let sharedExpander = XMNExpander()
    var expandItems: [XMNExpandedItem]
    
    private override init() {
        
        self.expandItems = [XMNExpandedItem]()
        super.init()
    }

    /// 注册监听Expand
    /// - warning:
    ///             需要在deinit 执行对应的 unexpand方法
    /// - Parameters:
    ///   - headerView: 需要放大的headerView
    ///   - scrollView: header对应的scrollView, 主要监听scrollView.contentOffset变化
    ///   - maxExpandHeight: 最大放大高度   默认0
    ///   - minExpandHeight: 最小放大高度   默认Int.max
    static func expand(headerView: UIView, inScrollView scrollView: UIScrollView, maxExpandHeight: CGFloat = CGFloat(Int.max), minExpandHeight: CGFloat = 0.0) {
        
        var exist = false
        for item in XMNExpander.sharedExpander.expandItems {
            
            if item.headerView == headerView {
                exist = true
                break
            }
        }
        if !exist {
            let expandedItem = XMNExpandedItem(scrollView: scrollView, headerView: headerView)
            expandedItem.maxHeight = maxExpandHeight
            expandedItem.minHeight = minExpandHeight
            XMNExpander.sharedExpander.expandItems.append(expandedItem)
        }
        
        print("still have \(XMNExpander.sharedExpander.expandItems)")
    }

    /// 取消expand 某个headerView
    ///
    /// - Parameter headerView: 需要取消的headerView
    static func unexpand(headerView: UIView) {
        
        let existItems: [XMNExpandedItem] = XMNExpander.sharedExpander.expandItems.filter { (item) -> Bool in
            
            if item.headerView == headerView {
                return false
            }
            return true
        }
        XMNExpander.sharedExpander.expandItems = existItems
        
        print("still have \(XMNExpander.sharedExpander.expandItems)")
    }
}
