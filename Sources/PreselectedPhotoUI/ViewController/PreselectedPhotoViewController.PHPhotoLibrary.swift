//
//  PreselectedPhotoViewController.PHPhotoLibrary.swift
//  
//
//  Created by Jaesung Lee on 2022/06/14.
//

import UIKit
import Photos

extension PreselectedPhotoViewController: PHPhotoLibraryChangeObserver {
    public func photoLibraryDidChange(_ changeInstance: PHChange) {
        guard let details = changeInstance.changeDetails(for: self.fetchResult) else { return }
        self.fetchResult = details.fetchResultAfterChanges
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.collectionView.reloadData()
        }
    }
}


