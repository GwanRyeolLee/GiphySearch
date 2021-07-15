//
//  GifListCollectionViewCell.swift
//  GiphySearch
//
//  Created by 이관렬 on 2021/07/03.
//

import UIKit
import Kingfisher

class GifListCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var imageView: AnimatedImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imageView.kf.indicatorType = .activity
    }

    func setImage(imageUrl: String) {
        guard let url = URL(string: imageUrl) else {
            return
        }
        
        imageView.kf.setImage(with: url)
    }
    
    override func prepareForReuse() {
        imageView.image = nil
    }
}
