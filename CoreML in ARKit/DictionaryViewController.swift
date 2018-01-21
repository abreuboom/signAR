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
    
    var breed: String?
    
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
        topView.roundCorners(corners: [.topLeft, .topRight], radius: 25)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        topView.roundCorners(corners: [.topLeft , .topRight], radius: 16)
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pets.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "petCell") as! UITableViewCell
        
        let pet = pets[indexPath.row]
        
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
}
