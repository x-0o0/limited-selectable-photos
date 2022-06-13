//
//  PreselectedPhotoViewController.swift
//  
//
//  Created by Jaesung Lee on 2022/06/14.
//

import UIKit
import Photos
import PhotosUI

open class PreselectedPhotoViewController: UIViewController, PhotoViewLifeCycle {
    
    // MARK: - Views
    public private(set) lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.estimatedItemSize = .zero
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsVerticalScrollIndicator = false
        return collectionView
    }()
    
    public var rightBarButton: UIBarButtonItem? = nil {
        didSet {
            self.navigationItem.rightBarButtonItem = self.rightBarButton
        }
    }
    
    private lazy var editButton: UIBarButtonItem = {
        let barButton = UIBarButtonItem(
            title: StringSet.viewLibrary,
            style: .plain,
            target: self,
            action: #selector(didTapRightBarButton)
        )
        barButton.tintColor = UIColor.blue
        return barButton
    }()
    
    // MARK: Data
    public weak var delegate: PreselectedPhotoViewDelegate?
    
    public var fetchResult: PHFetchResult<PHAsset> = PHAsset.fetchAssets(with: nil)
    
    // MARK: Layouts
    /// If it's `nil`, it returns the size that has 1/3 length of the window ‘s horizontal length
    public var columnSize: CGSize {
        customColumnSize ?? defaultColumnSize
    }
    
    private var customColumnSize: CGSize?
    
    private var defaultColumnSize: CGSize {
        let isPortrait = view.frame.height > view.frame.width
        let length = isPortrait ? (view.frame.width - 2) / 3 : (view.frame.height - 2) / 3
        return CGSize(width: length, height: length)
    }
    
    open override func loadView() {
        super.loadView()
        
        self.setupViews()
        self.setupLayouts()
        self.setupStyles()
        
        PHPhotoLibrary.shared().register(self)
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    deinit {
        PHPhotoLibrary.shared().unregisterChangeObserver(self)
    }
    
    open override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        self.setupStyles()
    }
    
    open func setupViews() {
        if self.rightBarButton == nil {
            self.rightBarButton = self.editButton
        }

        // Navigation Bar
        self.navigationItem.rightBarButtonItem = self.rightBarButton
        
        self.register(photoCell: PhotoCollectionViewCell(), nib: nil)
        self.view.addSubview(collectionView)
    }
    
    open func setupLayouts() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
    
    open func setupActions() {
        
    }
    
    open func setupStyles() {
        view.backgroundColor = .systemBackground
    }
    
    public func register(photoCell: PhotoCollectionViewCell, nib: UINib? = nil) {
        if let nib = nib {
            self.collectionView.register(nib, forCellWithReuseIdentifier: photoCell.className)
        } else {
            self.collectionView.register(type(of: photoCell), forCellWithReuseIdentifier: photoCell.className)
        }
    }
    
    @objc
    open func didTapRightBarButton() {
        PHPhotoLibrary.shared().presentLimitedLibraryPicker(from: self)
    }
}



