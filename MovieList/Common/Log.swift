//
//  Log.swift
//  MovieList
//
//  Created by 강건 on 2021/10/26.
//

import Foundation

//    MARK: - Log 확인할때 사용
public class Log {
    static func any(_ message: Any, file: String = #file, line: Int = #line) {
        let file = (file as NSString).lastPathComponent
        
        print("\(Date()) : \(message) (at \(file):\(line))")
    }
}
