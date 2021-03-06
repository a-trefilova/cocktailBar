//
//  DetailViewController.swift
//  CocktailBar
//
//  Created by Константин Сабицкий on 30.06.2020.
//  Copyright © 2020 Константин Сабицкий. All rights reserved.
//

import UIKit
import Nuke


class DetailViewController: UIViewController {
    
// MARK: - IBOutlets
    @IBOutlet weak var mainViewOutlet: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var cocktailImage: UIImageView!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var ingridient1Label: UILabel!
    @IBOutlet weak var ingridient2Label: UILabel!
    @IBOutlet weak var ingridient3Label: UILabel!
    @IBOutlet weak var ingridient4Label: UILabel!
    @IBOutlet weak var ingridient5Label: UILabel!
    @IBOutlet weak var ingridient6Label: UILabel!
    @IBOutlet weak var instructionLabel: UILabel!
    @IBOutlet weak var likeButtonOutlet: UIButton!
    @IBOutlet weak var ingridientsBackgroundView: UIView!
    
// MARK: - Public Properties
    var favVC = FavouritesViewController()
    var item: CurrentCocktail!
    var check: Bool = false
    var db: DBHelper = DBHelper()
    
// MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpOutlets()
        fillOutletsWithData()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        let tuple = db.selectItemInDB(drinkId: item.drinkId)
        if  tuple.1 == true {
            likeButtonOutlet.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        } else if tuple.1 == false {
            likeButtonOutlet.setImage(UIImage(systemName: "heart"), for: .normal)
        }
    }
   
    
// MARK: - Private Methods
    private func prepareOptionalValues(string: String?) -> String {
        guard let string = string else { return ""}
        if string.count >= 1 {
            return string
        }
        return ""
    }
 
    private func setUpOutlets() {
        nameLabel.layer.cornerRadius = 10
        nameLabel.clipsToBounds = true
               
        cocktailImage.layer.cornerRadius = 10
        cocktailImage.clipsToBounds = true
               
        transparencyGradient()
        
        categoryLabel.layer.cornerRadius = 10
        categoryLabel.clipsToBounds = true
               
        instructionLabel.layer.cornerRadius = 5
        instructionLabel.clipsToBounds = true
        
        likeButtonOutlet.layer.cornerRadius = 5
        likeButtonOutlet.clipsToBounds = true
        
        ingridientsBackgroundView.layer.cornerRadius = 10
        ingridientsBackgroundView.clipsToBounds = true
        ingridientsBackgroundView.layer.shadowRadius = 0.5
        ingridientsBackgroundView.layer.shadowOpacity = 0.5
    }
    
    private func transparencyGradient() {
        let maskLayer = CAGradientLayer(layer: cocktailImage.layer)
        maskLayer.colors = [UIColor.black.cgColor, UIColor.clear.cgColor]
        maskLayer.startPoint = CGPoint(x: 0, y: 0.7)
        maskLayer.endPoint = CGPoint(x: 0, y: 0)
        maskLayer.frame = cocktailImage.bounds
        cocktailImage.layer.mask = maskLayer
    }
    
    private func fillOutletsWithData() {
        nameLabel.text = item.drinkName
        categoryLabel.text = item.category
        instructionLabel.text = item.instructions
        ingridient1Label.text = item.ingridient1
        ingridient2Label.text = item.ingridient2
        ingridient3Label.text = item.ingridient3
        ingridient4Label.text = item.ingridient4
        ingridient5Label.text = item.ingridient5
        ingridient6Label.text = item.ingridient6
        
        guard let url = URL(string: item.imageUrl) else { return }
        Nuke.loadImage(with: url, into: cocktailImage)
    }
    
    
 // MARK: - IBActions
     @IBAction func likeButtonTapped(_ sender: UIButton) {
        //fatalError()
         print("LikeButtonTapped")
         check = !check
         
         if check == true {
             check = true
             sender.setImage(UIImage(systemName: "heart.fill"), for: .normal)
             db.updateFavouritesByDrinkId(drinkId: item.drinkId, bool: check)
             
         } else if check == false  {
             check = false
             sender.setImage(UIImage(systemName: "heart"), for: .normal)
             db.updateFavouritesByDrinkId(drinkId: item.drinkId, bool: check)

         }
         
     }
    
}

