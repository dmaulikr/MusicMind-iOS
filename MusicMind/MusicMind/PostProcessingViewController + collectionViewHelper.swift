//
//  PostProcessingViewController + collectionViewHelper.swift
//  MusicMind
//
//  Created by Angel Contreras on 3/17/17.
//  Copyright © 2017 MusicMind. All rights reserved.
//

import UIKit

extension PostProcessingViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return assets.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "emojiCell", for: indexPath) as? EmojiCollectionViewCell
        
        let emojiImage = assets[indexPath.row]
        cell?.updateWith(image: emojiImage)
        
        return cell ?? EmojiCollectionViewCell()
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // steps to add emoji to overlay layer
        /*
         1. add image view of emoji with pan gesture to move it around
         2. add all emojis to a collection to loop through
         3a. add videolayer to the parent layer
         3b. add each layer of each emoji in the collection to the parent layer
         4. flat the layers
         */
        
        //step 1
        let cell = collectionView.cellForItem(at: indexPath) as! EmojiCollectionViewCell
        let emojiImageView = cell.emojiImageView
        let newImageView = UIImageView(frame: (emojiImageView?.frame)!)
        newImageView.image = emojiImageView?.image
        newImageView.isUserInteractionEnabled = true
        newImageView.frame.origin = self.view.center
//        newImageView.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(detectPan(recognizer:))))
        
        self.avVideoExporter?.imageViews.append(newImageView)
        self.view.addSubview(newImageView)
        
        newImageView.frame = self.view.frame
        newImageView.translatesAutoresizingMaskIntoConstraints = false
        
        var constraints = [NSLayoutConstraint]()
        constraints += NSLayoutConstraint.constraints(withVisualFormat: "V:|[newImageView]|", options: [], metrics: nil, views: ["newImageView": newImageView])
        constraints += NSLayoutConstraint.constraints(withVisualFormat: "H:|[newImageView]|", options: [], metrics: nil, views: ["newImageView": newImageView])
        
        NSLayoutConstraint.activate(constraints)
        
        view.bringSubview(toFront: assetsButton)
        view.bringSubview(toFront: exportButton)
    }
}

// MARK: - Gesture Recognizer Methods
extension PostProcessingViewController {
    func detectPan(recognizer: UIPanGestureRecognizer){
        let translation = recognizer.translation(in: self.view)
        if let view = recognizer.view {
            view.center = CGPoint(x: view.center.x + translation.x, y: view.center.y + translation.y)
        }
        recognizer.setTranslation(CGPoint.zero, in: self.view)
    }
}
