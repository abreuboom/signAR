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
import Alamofire
import AlamofireImage
import CoreLocation

class BreedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate {
    
    var breed: String?
    var pets: [[String:Any]] = []
    let locationManager = CLLocationManager()
    
    @IBOutlet weak var topLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var topView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        let gestureDown = UISwipeGestureRecognizer(target: self, action: #selector(gestureSegue))
        gestureDown.direction = .down
        topView.addGestureRecognizer(gestureDown)
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        DispatchQueue.main.async() {
            self.tableView.reloadData()
        }
        topView.roundCorners(corners: [.topLeft, .topRight], radius: 25)
        getPetOfBreed(breed: breed!, completion: { (success) in
            if success == true {
                self.tableView.reloadData()
            }
        })
        topLabel.text = "\(breed!)'s Near You"
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "petCell") as! PetCell
        
        let pet = pets[indexPath.row]
        cell.pet = pet
        
        return cell
    }
    
    func getPetOfBreed(breed: String,
                       completion: @escaping (_ success: Bool) -> ()) {
        let api_key = "6031e303070ca81af94d5b194e8c112e"
        let breedName = String.lowercased(breed)().components(separatedBy: " ").first
        let petFinderEndpoint: String = "https://api.petfinder.com/pet.find?key=\(api_key)&format=json&output=basic&count=6&breed=\(breedName!)&location=MA"
        print(petFinderEndpoint)
        guard let url = URL(string: petFinderEndpoint) else {
            print("Error: cannot create URL")
            return
        }
        let urlRequest = URLRequest(url: url)
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: urlRequest) { (data, response, error) in
            // check for any errors
            guard error == nil else {
                print("error calling GET on /todos/1")
                print(error!)
                return
            }
            // make sure we got data
            guard let responseData = data else {
                print("Error: did not receive data")
                return
            }
            // parse the result as JSON, since that's what the API provides
            do {
                print(responseData)
                guard let dict = try JSONSerialization.jsonObject(with: responseData, options: [])
                    as? [String: Any] else {
                        print("error trying to convert data to JSON")
                        return
                }
                // now we have the todo
                // let's just print it to prove we can access it
                print("success")
                let petData = dict["petfinder"] as! [String: Any]
                let petsDict = petData["pets"] as! [String: Any]
                let pets = petsDict["pet"] as! [[String: Any]]
                for pet in pets {
                    self.pets.append(pet)
                }
                completion(true)
            } catch  {
                print("error trying to convert data to JSON???")
                return
            }
        }
        task.resume()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func gestureSegue() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!) {
        print("Location manager error: \(error.localizedDescription)")
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

extension UIView {
    func roundCorners(corners:UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
}
