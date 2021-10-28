//
//  Extension+String.swift
//  MovieList
//
//  Created by 강건 on 2021/10/27.
//

import UIKit

extension String {
    //    MARK: - Response Title 내용 중 검색어에 태그가 붙어서 나오는데 이를 제거함
    func removeTag() -> String{
        let first = "<b>"
        let last = "</b>"
        
        let removeFirst = self.replacingOccurrences(of: first, with: "")
        return removeFirst.replacingOccurrences(of: last, with: "")
    }
    
    //    MARK: - Response Director, Actor 내용에 | 문자가 포함되어 오는것을 , 로 대치한다
    func replaceBar() -> String {
        let removeLast = self.dropLast()
        return removeLast.replacingOccurrences(of: "|", with: ", ")
    }
    
    //    MARK: - Title에 적용하여 검색어를 강조되게 하는 속성을 부여한다
    func boldString(boldString: String) -> NSAttributedString {
        let attributedString = NSMutableAttributedString(string: self,
                                                         attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 13, weight: .regular)])
        let boldFontAttribute: [NSAttributedString.Key: Any] = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 13, weight: .bold)]
        let range = (self as NSString).range(of: boldString)
        attributedString.addAttributes(boldFontAttribute, range: range)
        return attributedString
    }
    
}
