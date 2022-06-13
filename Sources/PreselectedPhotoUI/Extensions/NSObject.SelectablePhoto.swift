//
//  NSObject.SelectablePhoto.swift
//  
//
//  Created by Jaesung Lee on 2022/06/14.
//

import Foundation

public extension NSObject {
    static var className: String {
        guard let className = String(describing: self).components(separatedBy: ".").last else {
            #if DEBUG
            print(String(describing: self))
            #endif
            fatalError("Class name couldn't find.")
        }
        return className
    }
    
    var className: String {
        guard let className = String(describing: self)
            .components(separatedBy: ":").first?
            .components(separatedBy: ".").last else {
            #if DEBUG
            print(String(describing: self))
            #endif
            fatalError("Class name couldn't find.")
        }
        return className
    }
}

