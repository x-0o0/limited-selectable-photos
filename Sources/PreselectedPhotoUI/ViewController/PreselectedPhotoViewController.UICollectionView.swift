//
//  PreselectedPhotoViewController.UICollectionView.swift
//  
//
//  Created by Jaesung Lee on 2022/06/14.
//

import UIKit
import Photos

extension PreselectedPhotoViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    open func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.fetchResult.count
    }
    
    open func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCollectionViewCell.className, for: indexPath) as! PhotoCollectionViewCell
        let asset = self.fetchResult[indexPath.item]
        let requestOptions = PHImageRequestOptions()
        requestOptions.isSynchronous = true
        PHImageManager().requestImage(for: asset, targetSize: self.columnSize, contentMode: .aspectFill, options: requestOptions) { [asset] (image, _) in
            cell.configure(image: image, forMediaType: asset.mediaType)
        }
        
        return cell
    }
    
    open func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.bounds.width/3 - 2), height: (collectionView.bounds.width/3))
    }
    
    open func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
    open func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
    
    open func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let asset = self.fetchResult[indexPath.item]
        
        switch asset.mediaType {
        case .image:
            // send data with media type
            let requestOptions = PHImageRequestOptions()
            PHImageManager().requestImage(for: asset, targetSize: PHImageManagerMaximumSize, contentMode: .aspectFill, options: requestOptions) { image, _ in
                guard let data = image?.jpegData(compressionQuality: 1.0) else {
                    #if DEBUG
                    print("No image data")
                    #endif
                    return
                }
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    self.delegate?.didTapSendImageData(data)
                    self.dismiss(animated: true, completion: nil)
                }
            }
        case .video:
            // send url or data with media type
            PHImageManager.default().requestAVAsset(forVideo: asset, options: nil) { (asset, audioMix, info) in
                guard let urlAsset = asset as? AVURLAsset else { return }
                let videoURL = urlAsset.url as URL
                print("send video")
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    self.delegate?.didTapSendVideoURL(videoURL)
                    self.dismiss(animated: true, completion: nil)
                }
            }
        default:
            // not supported
            print("not supported")
            self.dismiss(animated: true, completion: nil)
            return
        }
    }
}


