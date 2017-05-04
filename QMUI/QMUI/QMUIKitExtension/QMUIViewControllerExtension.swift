//
//  QMUIViewControllerExtension.swift
//  QMUI
//
//  Created by yaongfeng on 2017/5/4.
//  Copyright © 2017年 yaongfeng. All rights reserved.
//

import Foundation

extension UIViewController{

    open weak var qmuiPreviousViewController: UIViewController?{
        
        get{

            if let subCtrs = self.navigationController?.viewControllers {
                
                if (subCtrs.count > 1) && (self.navigationController?.topViewController == self){
                    return self.navigationController?.viewControllers[subCtrs.count - 2]
                }

            }
            return nil
            
  
        }
    }
    
    open var qmuiPreviousViewControllerTitle: String?
    {
        get{
            if let preCtr = self.qmuiPreviousViewController {
                if let preTitle = preCtr.title {
                    return String.init(stringLiteral: preTitle)
                }
            }
            return nil
        }
    }
    
    func qmuiIsViewLoadedAndVisible() -> Bool {
        return self.isViewLoaded && (self.view.window != nil)
    }
    
    func qmuiVisibleViewController() -> UIViewController? {
        if let presentedCtr = self.presentedViewController {
            return presentedCtr.qmuiVisibleViewController()
        }
        if self is UINavigationController {
            return  (self as! UINavigationController).topViewController?.qmuiVisibleViewController()
        }
        if self is UITabBarController {
            return (self as! UITabBarController).selectedViewController?.qmuiVisibleViewController()
        }
        
        if self.qmuiIsViewLoadedAndVisible(){
            return self
        }
        
        return nil
    }
    
    func qmuiIsTransitionTypePresented() -> Bool {
        if let navCtr = self.navigationController {
            
            if let index = navCtr.viewControllers.index(of: self) {
                if index > 0 {
                    return false
                }
            }
        }
        if self.presentingViewController != nil {
            return true
        }
        
        return false
    }
    
    
    
}
