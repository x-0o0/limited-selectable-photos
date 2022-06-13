//
//  PhotoCollectionViewCell.swift
//  
//
//  Created by Jaesung Lee on 2022/06/14.
//

import UIKit
import Photos

open class PhotoCollectionViewCell: UICollectionViewCell, PhotoViewLifeCycle {
    public var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    public var iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .center
        return imageView
    }()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setupViews()
        self.setupLayouts()
        self.setupActions()
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setupViews()
        self.setupLayouts()
        self.setupActions()
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        self.setupStyles()
    }
    
    /// This function handles the initialization of views.
    open func setupViews() {
        self.addSubview(imageView)
        self.addSubview(self.iconImageView)
    }
    
    /// This function handles the initialization of actions.
    open func setupActions() {
        
    }
    
    /// This function handles the initialization of autolayouts.
    open func setupLayouts() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            iconImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            iconImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            iconImageView.widthAnchor.constraint(equalToConstant: 48),
            iconImageView.heightAnchor.constraint(equalToConstant: 48)
        ])
        
        iconImageView.layoutIfNeeded()
    }
    
    open func configure(image: UIImage?, forMediaType mediaType: PHAssetMediaType) {
        self.imageView.image = image
        switch mediaType {
        case .video:
            self.iconImageView.image = UIImage(systemName: "play.circle.fill")
            self.iconImageView.backgroundColor = .clear
        default:
            self.iconImageView.backgroundColor = nil
            if self.imageView.image == nil {
                self.iconImageView.image = UIImage(systemName: "photo")
            } else {
                self.iconImageView.image = nil
            }
        }
        
    }
    
    /// This function handles the initialization of styles.
    open func setupStyles() {
        
    }
}


