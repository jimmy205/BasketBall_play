//
//  DetailVC.swift
//  PlayTogether
//
//  Created by Jimmy on 2017/7/6.
//  Copyright © 2017年 Jimmy. All rights reserved.
//

import UIKit
import MapKit

class DetailVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    
    @IBOutlet weak var detailImg: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var inputplaytime: UITextField!
    
    var play_array : [String] = []
    var message_array : [String] = []
    var location_id : String?
    var GymImg : String?
    var location_name : String?
    var lat : Double?
    var lng : Double?
    
    
    @IBAction func launchMaps(_ sender: Any) {
        openMapForPlace()
    }
    func openMapForPlace() {
        
        let latitude: CLLocationDegrees = lat!
        let longitude: CLLocationDegrees = lng!
        
        let regionDistance:CLLocationDistance = 10000
        let coordinates = CLLocationCoordinate2DMake(latitude, longitude)
        let regionSpan = MKCoordinateRegionMakeWithDistance(coordinates, regionDistance, regionDistance)
        let options = [
            MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center),
            MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span)
        ]
        let placemark = MKPlacemark(coordinate: coordinates, addressDictionary: nil)
        //let span = MKCoordinateSpanMake(0.75, 0.75)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = location_name
        mapItem.openInMaps(launchOptions: options)
    }
    
    
    
    func showPic(){
        do{
            if
                let url = URL(string:GymImg!) {
                let data = try Data(contentsOf: url)
                let img = UIImage(data: data)
                
                DispatchQueue.main.async {
                    self.detailImg.image = img
                }
            }else{
                DispatchQueue.main.async {
                    self.detailImg.image = UIImage(named: "Error.png")
                }
            }
        }catch{
            print(error)
        }
    }
    
    @IBAction func clickToInsert(_ sender: Any) {
        
        if inputplaytime.text != "" {
            let url = URL(string: "http://127.0.0.1/PlayTogether/playtogether.php")
            var req = URLRequest(url: url!)
            let currentime = get_currentime()
            
            req.httpBody = "GymId=\(location_id!)&PlayTime=\(inputplaytime.text!)&currentime=\(currentime)".data(using: String.Encoding.utf8)
            req.httpMethod = "POST"
            
            let session = URLSession(configuration: URLSessionConfiguration.default)
            
            let task = session.dataTask(with: req, completionHandler: {
                (data,response,error)  in
                if error == nil{
                    let str = String(data:data!,encoding: .utf8)
                    print(str!)
                    self.tableView.reloadData()
                }else{
                    print(error)
                }
            })
            task.resume()
            inputplaytime.text = ""
            getJson()
            print("OK2")
        }else {
            let myalert:UIAlertController = UIAlertController(title: "不可以唷", message: "請勿留空白", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default, handler:nil)
            myalert.addAction(action)
            present(myalert, animated: true, completion: nil)
            print ("XXX")
        }
    }
  
    func getJson(){
        do{
            
            // let url = Bundle.main.url(forResource: "mysql", withExtension: "html")
            let url = URL(string: "http://127.0.0.1/PlayTogether/playtime.php?GymId=\(location_id!)")
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
                    let playtime = v["playtime"] as! String
                    play_array += [playtime]
                    
                    let messageTime = v["MessageTime"] as! String
                    message_array += [messageTime]

                }
                
              //  print(allobj)
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            
        }catch{
            print(error)
        }
        
    }
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return play_array.count
    }
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "playtimecell") as! DetailVCTableViewCell
        
        cell.message.text = play_array[indexPath.row]
        cell.messageTime.text = message_array[indexPath.row]
        return cell
    }
    
    func get_currentime () -> String{
        let now = Date()
        let timeintervel : TimeInterval = now.timeIntervalSince1970
        let date = NSDate(timeIntervalSince1970: timeintervel)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM月dd日 HH:mm yyyy年 "
        dateFormatter.timeZone = TimeZone(identifier: "Taiwan/Taipei")
        
        let dateString = dateFormatter.string(from: date as Date)
        // print("formatted date is =  \(dateString)")
        return dateString
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showPic()
        getJson()
        // tableView.delegate = self
        // tableView.dataSource = self
    }
    
}
