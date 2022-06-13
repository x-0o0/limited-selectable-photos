//
//  ViewController.swift
//  SectablePhotoUIKit
//
//  Created by Jaesung Lee on 2022/06/14.
//

import UIKit
import PreselectedPhotoUI

class ViewController: UIViewController, PreselectedPhotoViewDelegate {
    @IBOutlet weak var photoSelectionButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func didTapPhotoSelection() {
        showLimitedPhotoLibraryPicker()
    }
    
    func showLimitedPhotoLibraryPicker() {
//        PreselectedPhotoViewController.StringSet.viewLibrary = "사진첩 보기"
        let selectablePhotoVC = PreselectedPhotoViewController()
        selectablePhotoVC.delegate = self
        let nav = UINavigationController(rootViewController: selectablePhotoVC)
        self.present(nav, animated: true, completion: nil)
    }
    
    func didTapSendImageData(_ data: Data) {
        // process image data
    }
    
    func didTapSendVideoURL(_ url: URL) {
        // process video url
    }
}

