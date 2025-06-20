//
//  +ImageCollectionViewController.swift
//  AppGallery
//
//  Created by Lukasz Fabia on 20/06/2025.
//

import UIKit

extension ImageCollectionViewController: ImageCellDelegate {
    func imageCollectionViewCellHandleFavButtonTap(_ cell: ImageCollectionViewCell) {
        guard let indPath = collectionView.indexPath(for: cell) else {return}
        
        guard let (isFav, title) = imageViewModel.toggleFavorite(at: indPath) else {return}
        
        cell.favButton.isSelected = isFav
        
        let message = isFav ? "Marked \(title) as Favorite!" : "Removed \(title) from Favorites."
        showAlert(cell, showAlertWithTitle: "Information", message: message)
        
    }
    
    private func showAlert(_ cell: ImageCollectionViewCell, showAlertWithTitle title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default))
        present(alert, animated: true)
    }
    

}
