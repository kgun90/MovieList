//
//  Extension+String.swift
//  MovieList
//
//  Created by 강건 on 2021/10/27.
//

import UIKit

extension String {
    func removeTag() -> String{
        let first = "<b>"
        let last = "</b>"
        
        let removeFirst = self.replacingOccurrences(of: first, with: "")
        return removeFirst.replacingOccurrences(of: last, with: "")
    }
    
    func replaceBar() -> String {
        let removeLast = self.dropLast()
        return removeLast.replacingOccurrences(of: "|", with: ", ")
    }
    
    func boldString(boldString: String) -> NSAttributedString {
        let attributedString = NSMutableAttributedString(string: self,
                                                         attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 13, weight: .regular)])
        let boldFontAttribute: [NSAttributedString.Key: Any] = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 13, weight: .bold)]
        let range = (self as NSString).range(of: boldString)
        attributedString.addAttributes(boldFontAttribute, range: range)
        return attributedString
    }
    
}
