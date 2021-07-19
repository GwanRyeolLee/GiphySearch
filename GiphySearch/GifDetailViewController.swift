//
//  GifDetailViewController.swift
//  GiphySearch
//
//  Created by greencar on 2021/07/06.
//

import UIKit
import Kingfisher

class GifDetailViewController: BaseUIViewController {

    @IBOutlet var imageView: AnimatedImageView!
    
    var image: Images?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar(title: "detail")
        
        guard let downsizedImage = image?.downsized, let url = URL(string: downsizedImage.url ?? ""),
              let width = Int(downsizedImage.width ?? "0"), let height = Int(downsizedImage.height ?? "0") else {
            return
        }
        imageView.frame.size = .init(width: width, height: height)
        imageView.kf.setImage(with: url)
    }
}
