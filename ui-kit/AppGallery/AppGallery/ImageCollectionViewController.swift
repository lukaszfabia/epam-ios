//
//  CollectionViewController.swift
//  AppGallery
//
//  Created by Lukasz Fabia on 20/06/2025.
//

import UIKit

private let reuseIdentifier = "ImageCollectionViewCell"
private let withReuseIdentifier = "SectionView"

class ImageCollectionViewController: UICollectionViewController {
    var imageViewModel = ImageViewModel(Image.dummies())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.contentInsetAdjustmentBehavior = .always
        
        view.backgroundColor = .systemBackground
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Register cell classes
        self.collectionView!.register(ImageCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        collectionView.register(SectionView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: withReuseIdentifier)
        
        
        // Do any additional setup after loading the view.
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using [segue destinationViewController].
     // Pass the selected object to the new view controller.
     }
     */
    
    // MARK: UICollectionViewDataSource
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return imageViewModel.numberOfSections()
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return imageViewModel.numberOfItems(in: section)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? ImageCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        // Configure the cell
        guard let img = imageViewModel.image(at: indexPath) else {return UICollectionViewCell()}
        
        cell.use(with: img)
        cell.alertDelegate = self
        
        return cell
    }
    
    // MARK: UICollectionViewDelegate
    
    override func collectionView(_ collectionView: UICollectionView,
                                 viewForSupplementaryElementOfKind kind: String,
                                 at indexPath: IndexPath) -> UICollectionReusableView {
        guard
            kind == UICollectionView.elementKindSectionHeader,
            let sectionView = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: withReuseIdentifier,
                for: indexPath
            ) as? SectionView
        else {
            return UICollectionReusableView()
        }
        
        let year = imageViewModel.year(at: indexPath.section)
        sectionView.use(with: year)
        
        return sectionView
    }
    
}
