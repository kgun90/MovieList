//
//  Device.swift
//  MovieList
//
//  Created by 강건 on 2021/10/26.
//

import UIKit

struct Device {
    // MARK: 노치 디자인인지 아닌지 판단
    static var isNotch: Bool {
        return Double(UIApplication.shared.windows.first?.safeAreaInsets.bottom ?? -1) > 0
    }
    
    // MARK: 상태바 높이
    static var statusBarHeight: CGFloat {
        return UIApplication.shared.windows.first?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
    }
    
    // MARK: 네비게이션 바 높이
    static var navigationBarHeight: CGFloat {
        return UINavigationController().navigationBar.frame.height
    }
    
    // MARK: 상태바 높이 + 네비게이션 바 높이
    static var topHeight: CGFloat {
        return statusBarHeight + navigationBarHeight
    }
    // MARK: 화면높이
    static var screenHeight: CGFloat {
        return UIScreen.main.bounds.height
    }
    // MARK: 화면너비
    static var screenWidth: CGFloat {
        return UIScreen.main.bounds.width
    }
    // MARK: 노치 유무에 따른 화면 높이 계산
    static func heightScale(_ size: CGFloat) -> CGFloat {
        return self.isNotch ? UIScreen.main.bounds.height * (size / 812) : UIScreen.main.bounds.height * (size / 667)
        
    }
    // MARK: 화면너비에 맞는 너비 사이즈 계산
    static func widthScale(_ size: CGFloat) -> CGFloat {
        return UIScreen.main.bounds.width * (size / 375)
    }
}
