//
//  Extension+UINavigationController.swift
//  MovieList
//
//  Created by 강건 on 2021/10/27.
//

import UIKit
//    MARK: - Custom Navigation 사용시 Swipe로 뒤로가는 동작이 안되는 문제를 위한 Extension
extension UINavigationController: ObservableObject, UIGestureRecognizerDelegate {
    override open func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.isHidden = true
        interactivePopGestureRecognizer?.delegate = self
    }

    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return viewControllers.count > 1
    }
}
