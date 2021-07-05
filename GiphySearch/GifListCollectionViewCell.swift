//
//  GifListCollectionViewCell.swift
//  GiphySearch
//
//  Created by 이관렬 on 2021/07/03.
//

import UIKit

class GifListCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    func imageSet(imageUrl: URL) {
        DispatchQueue.global().async {
            let data = try? Data(contentsOf: imageUrl)
            DispatchQueue.main.async {
                self.imageView.image = UIImage(data: data!)
            }
        }
    }
    
    override func prepareForReuse() {
        imageView.image = nil
    }
}
