//
//  BreedViewController.swift
//  CoreML in ARKit
//
//  Created by John Abreu on 10/21/17.
//  Copyright © 2017 CompanyName. All rights reserved.
//
//  API Key
//  6031e303070ca81af94d5b194e8c112e
//  API Secret
//  24e5915fd5b36e8d7b99d9220805a8bb

import UIKit
import CoreLocation

class DictionaryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate {
    
    let userDefaults = UserDefaults.standard
    var phrases = [""]
    var dates = [""]
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var topView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        let gestureDown = UISwipeGestureRecognizer(target: self, action: #selector(gestureSegue))
        gestureDown.direction = .down
        topView.addGestureRecognizer(gestureDown)
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        DispatchQueue.main.async() {
            self.tableView.reloadData()
        }
        fetchPhrases()
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    func fetchPhrases() {
        let keys = userDefaults.object(forKey: "keys") as! [String]
        for key in keys {
            let phrase = userDefaults.string(forKey: key)
            dates.append(key)
            phrases.append(phrase!)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return phrases.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "phraseCell") as! PhraseCell
        
        cell.cardView.layer.cornerRadius = 10
        cell.cardView.dropShadow()
        
        cell.name.text = phrases[indexPath.row]
        cell.date.text = dates[indexPath.row]
        
        return cell
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func gestureSegue() {
        self.dismiss(animated: true, completion: nil)
    }
    
}

extension UIView {
    func roundCorners(corners:UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
    
    func dropShadow() {
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.05
        self.layer.shadowOffset = CGSize(width: 0, height: 4)
        self.layer.shadowRadius = 7
    }
}
