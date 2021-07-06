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
    var searchText: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar(hidden: true)
        gifCollectionView.delegate = self
        gifCollectionView.dataSource = self
        searchTextField.delegate = self
        gifCollectionView?.contentInset = UIEdgeInsets(top: 23, left: 10, bottom: 10, right: 10)
        gifCollectionView.register(UINib(nibName: "GifListCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "gifCell")
        if let layout = gifCollectionView?.collectionViewLayout as? GiphyLayout {
            layout.delegate = self
        }
    }
    
    func searchGif(page: Int = 0) {
        var parameters: [String: Any] = [:]
        parameters["api_key"] = API_KEY
        parameters["q"] = searchText
        parameters["offset"] = page
        APIManager.requestWithName(API_SEARCH, method: .get, parameters: parameters, responseType: GiphyListModel.self) { result in
            switch result {
            case .success(let res):
                guard let data = res.data, let pagination = res.pagination else {
                    return
                }
                self.giphyDataList = data
                self.pagination = pagination
                self.gifCollectionView.reloadData()
            case .failure(_):
                self.giphyDataList = nil
                self.pagination = nil
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
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if(self.gifCollectionView.contentOffset.y >= (self.gifCollectionView.contentSize.height - self.gifCollectionView.bounds.size.height)) {
            guard let page = pagination?.offset, let count = pagination?.count, let totalCount = pagination?.total_count else {
                return
            }
            searchGif(page: page + 1)
        }
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
        let collectionViewHalfWidth = (collectionView.bounds.width / 2)
        let ratio = collectionViewHalfWidth / CGFloat(downloadedImageWidth)
        
        return downloadedImageHeight * ratio
    }
}

extension SearchViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchText = textField.text
        searchGif()
        self.view.endEditing(true)
        return true
    }
}
