//
//  PetCell.swift
//  CoreML in ARKit
//
//  Created by John Abreu on 10/21/17.
//  Copyright © 2017 CompanyName. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class PetCell: UITableViewCell {
    
    @IBOutlet weak var photoView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var breedLabel: UILabel!
    @IBOutlet weak var sexLabel: UILabel!
    
    
    var pet: [String: Any]! {
        didSet {
            photoView.image = nil
            
            photoView.layer.cornerRadius = photoView.frame.width/2
            photoView.mask?.clipsToBounds = true
            
            let name = (pet["name"] as! [String: Any])["$t"] as! String
            let mix = (pet["mix"] as! [String: Any])["$t"] as! String
            let age = (pet["age"] as! [String: Any])["$t"] as! String
            let sex = (pet["sex"] as! [String: Any])["$t"] as! String
            let shelterID = (pet["shelterId"] as! [String: Any])["$t"] as! String
            let media = pet["media"] as! [String: Any]
            if let photosDict = media["photos"] as? [String: Any] {
                let photos = photosDict["photo"] as! [[String: Any]]
                let photoDict = photos[0]
                let photoUrlString = photoDict["$t"] as! String
                let photoUrl = URL(string: photoUrlString)
                //photoView.af_setImage(withURL: photoUrl!)
                Alamofire.request(photoUrl!).responseImage { (response) in
                    if let imageData = response.result.value {
                        let image = imageData.af_imageAspectScaled(toFill: CGSize(width: 300, height: 300)).af_imageRounded(withCornerRadius: 25)
                        self.photoView?.image = image
                    }
                }
                
                print(photoUrl!)
            }
            
            nameLabel.text = name
            ageLabel.text = age
            sexLabel.text = sex
            if sex == "M" {
                sexLabel.textColor = UIColor(red: 158/255, green: 197/255, blue: 219/255, alpha: 1.0)
            }
            else {
                sexLabel.textColor = UIColor(red: 239/255, green: 183/255, blue: 227/255, alpha: 1.0)
            }
            
            if mix == "yes" {
                breedLabel.text = "Mix"
            } else {
                let breeds = pet["breeds"] as! [String: Any]
                let breed = (breeds["breed"] as! [String: Any])["$t"] as! String
                breedLabel.text = breed
            }
            
            
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

extension UIImage {
    
    func crop(to:CGSize) -> UIImage {
        guard let cgimage = self.cgImage else { return self }
        
        let contextImage: UIImage = UIImage.init(cgImage: cgimage)
        
        let contextSize: CGSize = contextImage.size
        
        //Set to square
        var posX: CGFloat = 0.0
        var posY: CGFloat = 0.0
        let cropAspect: CGFloat = to.width / to.height
        
        var cropWidth: CGFloat = to.width
        var cropHeight: CGFloat = to.height
        
        if to.width > to.height { //Landscape
            cropWidth = contextSize.width
            cropHeight = contextSize.width / cropAspect
            posY = (contextSize.height - cropHeight) / 2
        } else if to.width < to.height { //Portrait
            cropHeight = contextSize.height
            cropWidth = contextSize.height * cropAspect
            posX = (contextSize.width - cropWidth) / 2
        } else { //Square
            if contextSize.width >= contextSize.height { //Square on landscape (or square)
                cropHeight = contextSize.height
                cropWidth = contextSize.height * cropAspect
                posX = (contextSize.width - cropWidth) / 2
            }else{ //Square on portrait
                cropWidth = contextSize.width
                cropHeight = contextSize.width / cropAspect
                posY = (contextSize.height - cropHeight) / 2
            }
        }
        
        let rect: CGRect = CGRect(x: posX, y: posY, width: cropWidth, height: cropHeight)
        
        // Create bitmap image from context using the rect
        let imageRef: CGImage = contextImage.cgImage!.cropping(to: rect)!
        
        // Create a new image based on the imageRef and rotate back to the original orientation
        let cropped: UIImage = UIImage.init(cgImage: imageRef, scale: self.scale, orientation: self.imageOrientation)
        
        UIGraphicsBeginImageContextWithOptions(to, true, self.scale)
        cropped.draw(in: CGRect(x: 0, y: 0, width: to.width, height: to.height))
        let resized = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return resized!
    }
}
