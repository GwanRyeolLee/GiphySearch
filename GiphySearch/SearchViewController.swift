//
//  SearchViewController.swift
//  GiphySearch
//
//  Created by 이관렬 on 2021/07/01.
//

import UIKit

class SearchViewController: BaseUIViewController {
    
    @IBOutlet weak var gifCollectionView: UICollectionView!
    @IBOutlet weak var searchTextField: UITextField!
    
    var giphyDataList: [GiphyDataList]?
    var pagination: Pagenation?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar(hidden: true)
        gifCollectionView.delegate = self
        gifCollectionView.dataSource = self
        searchTextField.delegate = self
        gifCollectionView.register(UINib(nibName: "GifListCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "gifCell")
        if let layout = gifCollectionView?.collectionViewLayout as? GiphyLayout {
            layout.delegate = self
        }
    }
    
    func searchGif() {
        var parameters: [String: Any] = [:]
        parameters["api_key"] = "uQDgkReJGLt6ATendvynLoMHuHnk5OQy"
        parameters["q"] = searchTextField.text
        APIManager.requestWithName(API_SEARCH, method: .get, parameters: parameters, responseType: GiphyListModel.self) { result in
            switch result {
            case .success(let res):
                guard let data = res.data else {
                    return
                }
                self.giphyDataList = data
                self.gifCollectionView.reloadData()
            case .failure(_):
                return
            }
        }
    }
}

extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return giphyDataList?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "gifCell", for: indexPath) as? GifListCollectionViewCell else {
            return UICollectionViewCell()
        }
        guard let imageUrl = giphyDataList?[indexPath.row].images?.original_still?.url, let url = URL(string: imageUrl) else {
            return UICollectionViewCell()
        }
        
        cell.imageSet(imageUrl: url)
        return cell
    }
}

extension SearchViewController: GiphyLayoutDelegate {
    func collectionView(_ collectionView: UICollectionView, heightForPhotoAtIndexPath indexPath: IndexPath) -> CGFloat {
        guard let giphyDataList = giphyDataList, let width = giphyDataList[indexPath.row].images?.original_still?.width,
              let height = giphyDataList[indexPath.row].images?.original_still?.height else {
            return 0
        }
        let downloadedImageWidth = CGFloat(NSString(string: width).floatValue)
        let downloadedImageHeight = CGFloat(NSString(string: height).floatValue)
        let insets = collectionView.contentInset
        let collectionViewHalfWidth = collectionView.bounds.width - (insets.left + insets.right)
        
        let widthOffset = downloadedImageWidth - (collectionViewHalfWidth / 2)
        let widthOffsetPercentage = (widthOffset * 100)/downloadedImageWidth
        let heightOffset = (widthOffsetPercentage * downloadedImageHeight) / 100
        let effectiveHeight = downloadedImageHeight - heightOffset

        return effectiveHeight
    }
}

extension SearchViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchGif()
        self.view.endEditing(true)
        return true
    }
}