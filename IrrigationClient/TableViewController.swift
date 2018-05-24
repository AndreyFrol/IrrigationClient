//
//  TableViewController.swift
//  IrrigationClient
//
//  Created by Antonchikov Alexander on 24/05/2018.
//  Copyright © 2018 Antonchikov Alexander. All rights reserved.
//

import UIKit
import Alamofire

class TableViewController: UITableViewController {

    let humidityUrl : String = GlobalVariables.sharedManager.getBaseUrl()+"humidity"
    let pumpUrl : String = GlobalVariables.sharedManager.getBaseUrl()+"pump"
    let humiditySettingsUrl : String = GlobalVariables.sharedManager.getBaseUrl()+"humidity-settings"

    
    
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var pumpStatus: UISwitch!
    
    @IBOutlet weak var freqLabel: UITextField!    
    @IBOutlet weak var irrigTimeLabel: UITextField!
    @IBOutlet weak var thresholdLabel: UITextField!
    
    @IBOutlet weak var switchPump: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let headers: HTTPHeaders = [
            "Authorization": "JWT " + GlobalVariables.sharedManager.getAccessToken(),
            //"Accept": "application/json"
        ]
        
        Alamofire.request(humidityUrl, method: .get, encoding: JSONEncoding.default).responseJSON {
            [weak self] response in
            guard let strongSelf = self else { return }
            guard response.result.isSuccess else { print("error result"); return }
            guard let dictionary = response.result.value as? Dictionary<String, Any> else { return }
            print(dictionary)
            guard let humidity = dictionary["humidity"] as? Dictionary<String, String> else { return }
            strongSelf.humidityLabel.text = humidity["percent"]! + "%"
        }
        
        Alamofire.request(pumpUrl, method: .get, encoding: JSONEncoding.default).responseJSON {
            [weak self] response in
            guard let strongSelf = self else { return }
            guard response.result.isSuccess else { print("error result"); return }
            guard let dictionary = response.result.value as? Dictionary<String, String> else { return }
            let flag = dictionary["status"] == "on" ? true : false
            strongSelf.pumpStatus.isOn = flag
            strongSelf.switchPump.isOn = flag
        }
        
        Alamofire.request(humiditySettingsUrl, method: .get, encoding: JSONEncoding.default).responseJSON {
            [weak self] response in
            guard let strongSelf = self else { return }
            guard response.result.isSuccess else { print("error result"); return }
            guard let dictionary = response.result.value as? Dictionary<String, String> else { return }
            
            strongSelf.freqLabel.text = dictionary["freq"]
            strongSelf.irrigTimeLabel.text = dictionary["irrigation_time"]
            strongSelf.thresholdLabel.text = dictionary["threshold"]
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 3
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if section == 0 {
            return 2
        }
        
        if section == 1 {
            return 3
        }
        if section == 2 {
            return 2
        }
        return 0
    }
    
    

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func switchPump(_ sender: Any) {
        if switchPump.isOn {
            Alamofire.request(GlobalVariables.sharedManager.getBaseUrl()+"on", method: .get, encoding: JSONEncoding.default).responseJSON {
                [weak self] response in
                guard let strongSelf = self else { return }
                guard response.result.isSuccess else { print("error result"); return }
                strongSelf.pumpStatus.isOn = true
            }
        } else {
            Alamofire.request(GlobalVariables.sharedManager.getBaseUrl()+"off", method: .get, encoding: JSONEncoding.default).responseJSON {
                [weak self] response in
                guard let strongSelf = self else { return }
                guard response.result.isSuccess else { print("error result"); return }
                strongSelf.pumpStatus.isOn = false
            }
        }
        
    }
    
    @IBAction func logout(_ sender: UIButton) {
        self.performSegue(withIdentifier: "logout", sender: self)

    }
    
}
