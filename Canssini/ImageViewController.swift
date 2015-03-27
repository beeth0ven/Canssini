//
//  ImageViewController.swift
//  Canssini
//
//  Created by luojie on 3/27/15.
//  Copyright (c) 2015 luojie. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController ,UIScrollViewDelegate{
    
    var imageURL : NSURL! {
        didSet {
            image = nil
            if view.window != nil {
                fetchImage()
            }
        }
    }
    
    private func fetchImage(){
        if let url = imageURL {
            spinner.startAnimating()
            let qos = Int(QOS_CLASS_USER_INITIATED.value)
            dispatch_async(dispatch_get_global_queue(qos, 0) , { () -> Void in
                let imageData = NSData(contentsOfURL: url)
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    if url == self.imageURL {
                        if imageData != nil {
                            self.image = UIImage(data: imageData!)
                        }else{
                            self.image = nil
                        }
                    }
     
                })
 
            })
            
        }
    }
    
    private var imageView = UIImageView()
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    private var image :UIImage?{
        get { return imageView.image }
        set {
            imageView.image = newValue
            imageView.sizeToFit()
            scrollView?.contentSize = imageView.frame.size
            spinner?.stopAnimating()
        }
    }
    
    @IBOutlet weak var scrollView: UIScrollView! {
        didSet {
            scrollView.contentSize = imageView.frame.size
            scrollView.delegate = self
            scrollView.minimumZoomScale = 0.03
            scrollView.maximumZoomScale = 1.0
        }
    }
    
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
    override func viewDidLoad() {
        scrollView.addSubview(imageView)

    }
    
    override func viewWillAppear(animated: Bool) {
        if image == nil {
            fetchImage()
        }
    }

}
