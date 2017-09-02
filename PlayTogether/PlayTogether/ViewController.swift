//
//  ViewController.swift
//  PlayTogether
//
//  Created by Jimmy on 2017/7/6.
//  Copyright © 2017年 Jimmy. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,CLLocationManagerDelegate {

    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    @IBAction func backHere(segue: UIStoryboardSegue){
        print("back home")
    }
    
    let lmgr = CLLocationManager()
    var searchController : UISearchController!
//    var shouldShowSearch : Bool = false
//    var filterArray : [String] = []
//    var location : [String] = []
//    var GymId : [String] = []
//    var Gym_img : [String] = []
//    var GymDistance : [String] = []
//    var address_array : [String] = []
    var dis = [[String:String]]()
    var sortdis = [[String:String]]()
   
    func getJson(){
        do{
            let url = Bundle.main.url(forResource: "location_Json", withExtension: "html")
            let data = try! Data(contentsOf: url!)
            parseJson(json: data)
        }catch{
            print(error)
        }
    }
    
    func parseJson(json:Data){
        do{
            if let jsonObj = try? JSONSerialization.jsonObject(with: json, options: .allowFragments){
                let allobj = jsonObj as! [[String:AnyObject]]
                
                for v in allobj{
                    let name = v["GName"] as! String
                    
                    let gid = v["GymId"] as! String
                    
                    let limg = v["Photo1"] as! String
                    
                    let address = v["Address"] as! String
                    
                    let latlng = v["LatLng"] as! String
                    let distance = getdistance(latlng:latlng)
                    
                    dis += [["location" : name, "address" : address ,"distance":distance,"GymId":gid,"Gym_img":limg,"latlng":latlng ]]
                }
                sortdis = dis.sorted(by: { $0["distance"]! < $1["distance"]! })
                print(sortdis)
            }
        }catch{
            print(error)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail"{
            if let indexPath = self.tableView.indexPathForSelectedRow{
           
                let sortdis = self.sortdis[indexPath.row]
                let location_id = sortdis["GymId"]
                let location_img = sortdis["Gym_img"]
                let controller = segue.destination as! DetailVC
                controller.location_id = location_id
                controller.GymImg = location_img
                let splitlatlng = sortdis["latlng"]?.components(separatedBy: ",")
                controller.lat = Double(splitlatlng![0])
                controller.lng = Double(splitlatlng![1])
                controller.location_name = sortdis["location"]
            }
        }
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
            return dis.count
    }
   
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomerCell") as! customerTableViewCell
       
           
            let sortdis = self.sortdis[indexPath.row]
            cell.location.text = sortdis["location"]!
            cell.distance.text = "\(sortdis["distance"]!)  Km"
            cell.Adress.text = sortdis["address"]
        
        return cell
    }
    
    func getdistance (latlng: String) -> String {
        
        let current_lat = lmgr.location?.coordinate.latitude
        let current_lng = lmgr.location?.coordinate.longitude
        
        let splitLatlng = latlng.components(separatedBy: ",")
        
        let coordinate0 = CLLocation(latitude: current_lat!, longitude: current_lng!)
        let coordinate1 = CLLocation(latitude: Double(splitLatlng[0])!, longitude: Double(splitLatlng[1])!)
        
        let distanceinmeter = coordinate0.distance(from: coordinate1)
        let distance = Double((distanceinmeter)/1000)
       // print(Int((distanceinmeter)/1000))
        print(distance)
        //let sdistance = String(distance)
        //let tsdistance = String(format: "%.2f", sdistance)
        return String(format: "%.2f", distance)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        getJson()
        lmgr.requestAlwaysAuthorization()
        lmgr.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
}

