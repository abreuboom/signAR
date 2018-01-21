//
//  DetailViewController.swift
//  CoreML in ARKit
//
//  Created by Maxine Kwan on 1/20/18.
//  Copyright © 2018 CompanyName. All rights reserved.
//

import UIKit
import ScalingCarousel

class DetailViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var sentenceView: UITextField!
    @IBOutlet weak var collectionView: ScalingCarouselView!
    
    var str = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        
        // Testing purposes
        sentenceView.text = "HOW MUCH"
        
        str = (sentenceView.text?.removingWhitespaces())!
    
        // Do any additional setup after loading the view.
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (str.count)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LetterCell", for: indexPath) as! LetterCell
        let index = str.index(sentenceView.text!.startIndex, offsetBy: indexPath.row)
        cell.alphabetLabel.text = String(str[index])
        cell.signView.image = UIImage(named: String(str[index]))
        
        return cell
    }
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        collectionView.didScroll()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

// Removes white spaces from words only displays letters
extension String {
    func removingWhitespaces() -> String {
        return components(separatedBy: .whitespaces).joined()
    }
}
