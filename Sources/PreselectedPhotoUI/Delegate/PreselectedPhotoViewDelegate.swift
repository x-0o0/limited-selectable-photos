//
//  PreselectedPhotoViewDelegate.swift
//  
//
//  Created by Jaesung Lee on 2022/06/14.
//

import Foundation

public protocol PreselectedPhotoViewDelegate: AnyObject {
    func didTapSendImageData(_ data: Data)
    
    func didTapSendVideoURL(_ url: URL)
}
