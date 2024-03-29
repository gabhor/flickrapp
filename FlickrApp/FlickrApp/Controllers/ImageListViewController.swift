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
    private var presenter = ImageListPresenter()
    @IBOutlet private weak var searchBar: UISearchBar!
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var noPhotoLabel: UILabel!

    override var preferredStatusBarStyle : UIStatusBarStyle {
        return .lightContent
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.view = self
        initUserInterface()
        startSearch()
        updateThumbnails()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        coordinator.animate(alongsideTransition: nil, completion: {
            [weak self] _ in
            guard let strongSelf = self else { return }
            DispatchQueue.main.async {
                strongSelf.updateThumbnails()
            }
        })
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constant.App.showDetailSegue {
            if let cell = sender as? PhotoCell, let indexPath = collectionView.indexPath(for: cell) {
                let object = presenter.photo(at: indexPath.row)
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

// MARK: - UICollectionViewDelsegate

extension ImageListViewController : UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == presenter.numberOfPhotos()-1 {
            presenter.loadNextPage()
        }
    }
}

// MARK: - UICollectionViewDataSource

extension ImageListViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.numberOfPhotos()
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constant.App.photoCellIdentifier, for: indexPath)
        if let cell = cell as? PhotoCell, let photoData = presenter.photo(at: indexPath.row) {
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
    func isLoading(_ loading: Bool) {
        searchBar.searchTextField.isEnabled = !loading
    }

    func refresh() {
        DispatchQueue.main.async {
            self.updateThumbnails()
        }
    }

    func update(with error: Error) {
        DispatchQueue.main.async {
            self.updateThumbnails()
            UIAlertController.showErrorDetails(error: error)
        }
    }
}

// MARK: - Private extension

private extension ImageListViewController {
    func initUserInterface() {
        initSplitView()
        initSearchBar()
        initAppearance()
        initTexts()
    }

    func initTexts() {
        title = "mainScreenTitle".localized
        noPhotoLabel.text = "noPhoto".localized
    }

    func initAppearance() {
        noPhotoLabel.font = UIFont.bigBoldFont
        noPhotoLabel.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        view.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        collectionView.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        searchBar.barTintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        if #available(iOS 13.0, *) {
            searchBar.searchTextField.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        }
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white,
                                                                   NSAttributedString.Key.font: UIFont.homeScreenHeaderFont]
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    }

    func initSplitView() {
        if let split = splitViewController {
            let controllers = split.viewControllers
            detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? ImageDetailsViewController
        }
    }

    func initSearchBar() {
        searchBar.text = presenter.initialSearchText()
    }

    func startSearch() {
        guard let keyword = searchBar.text else { return }
        
        presenter.startSearch(with: keyword)
    }

    func updateThumbnails() {
        if presenter.numberOfPhotos() > 0 {
            noPhotoLabel.isHidden = true
            collectionView.isHidden = false
        } else {
            noPhotoLabel.isHidden = false
            collectionView.isHidden = true
        }
        collectionView.reloadData()
    }
}
