//
//  ImageListViewController.swift
//  FlickrApp
//
//  Created by Gabor Horvath on 2019. 10. 01..
//  Copyright © 2019. Gabor Horvath. All rights reserved.
//

import UIKit

class ImageListViewController: UIViewController {

    var detailViewController: ImageDetailsViewController? = nil
    private var photos = [FlickrPhoto]()
    private var presenter = ImageListPresenter()

    @IBOutlet private weak var searchBar: UISearchBar!
    @IBOutlet private weak var collectionView: UICollectionView!


    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.view = self
        initUserInterface()
        startSearch()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    // MARK: - Segues

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constant.App.showDetailSegue {
            if let cell = sender as? PhotoCell, let indexPath = collectionView.indexPath(for: cell) {
                let object = photos[indexPath.row]
                let controller = (segue.destination as! UINavigationController).topViewController as! ImageDetailsViewController
                controller.detailItem = object
                controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }
}

// MARK: - UISearchBarDelegate

extension ImageListViewController : UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
        startSearch()
    }
}

// MARK: - UICollectionViewDataSource

extension ImageListViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constant.App.photoCellIdentifier, for: indexPath)
        let photoData = photos[indexPath.row]
        if let cell = cell as? PhotoCell {
            cell.displayPhoto(photoData)
        }
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension ImageListViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellSize = collectionView.frame.size.width/2 - 16
        return CGSize(width: cellSize, height: cellSize)
    }

}

// MARK: - ImageListViewProtocol

extension ImageListViewController : ImageListViewProtocol {
    func update(with photoList: [FlickrPhoto]) {
        updateThumbnails(photoList)
    }

    func update(with error: Error) {
        updateThumbnails([])
    }
}

// MARK: - Privíte extension

private extension ImageListViewController {
    func initUserInterface() {
        initSplitView()
        initSearchBar()
        initCollectionView()
    }

    func initSplitView() {
        if let split = splitViewController {
            let controllers = split.viewControllers
            detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? ImageDetailsViewController
        }
    }

    func initCollectionView() {
        
    }

    func initSearchBar() {
        searchBar.text = Constant.App.initialSearchText 
    }

    func startSearch() {
        guard let keyword = searchBar.text else { return }

        updateThumbnails([])
        presenter.startSearch(with: keyword)
    }

    func updateThumbnails(_ list: [FlickrPhoto]) {
        photos = list
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
}
