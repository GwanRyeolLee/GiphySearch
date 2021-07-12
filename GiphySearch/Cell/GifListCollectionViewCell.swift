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

    func setImage(imageUrl: String) {
        
        if let cacheImage = CacheManager.shared.object(forKey: imageUrl as NSString) {
            imageView.image = cacheImage
            return
        }
        
        DispatchQueue.global().async {
            guard let url = URL(string: imageUrl), let data = try? Data(contentsOf: url),
                  let image = UIImage(data: data) else {
                return
            }
            DispatchQueue.main.async {
                CacheManager.shared.setObject(image, forKey: imageUrl as NSString)
                self.imageView.image = image
            }
        }
    }
    
    override func prepareForReuse() {
        imageView.image = nil
    }
}
