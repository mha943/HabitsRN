//
//  HabitImageCollectionViewCell.swift
//  HabitsRN
//
//  Created by Matthew Hall on 3/6/21.
//

import UIKit

class HabitImageCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var habitImage: UIImageView!
    
    static let identifier = "HabitImageCell"
    
    static var nib: UINib{
        return UINib(nibName: String(describing: self), bundle: nil)
    }
    
    // given an image and a boolean, set the image to grayish green
    func setImage(image: UIImage, withSelection: Bool){
        if withSelection {
            self.habitImage.image = image.withRenderingMode(.alwaysOriginal)
        }else{
            self.habitImage.image = image.withRenderingMode(.alwaysTemplate)
            self.habitImage.tintColor = UIColor.init(red: 0.5, green: 0.6, blue: 0.5, alpha: 1)
        }
    }
    
}

