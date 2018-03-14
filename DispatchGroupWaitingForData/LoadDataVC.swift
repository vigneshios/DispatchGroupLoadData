//
//  LoadDataVC.swift
//  DispatchGroupWaitingForData
//
//  Created by Apple on 13/03/18.
//  Copyright © 2018 Vignesh. All rights reserved.
//

import UIKit

class LoadDataVC: UIViewController {

    // Outlets
    @IBOutlet weak var tableView: UITableView!
    
    // Variables
    var dataSet1 = ["One", "Two"]
    var dataSet2 = ["Three", "Four"]
    var dataSet3 = ["Five", "Six"]
    var dataSet4 = ["Seven", "Eight"]
    var dataSet5 = ["Nine", "Ten"]
    var datas = [String]()
    
    // Constants
    let cellId = "loadDataCell"
    let dispatchGroup = DispatchGroup()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
    }
    
    func run(after seconds: Int, completion: @escaping () -> Void){
        let deadline = DispatchTime.now() + .seconds(seconds)
        DispatchQueue.main.asyncAfter(deadline: deadline) {
            completion()
        }
    }
    
    
    func getDataSet1() {
        dispatchGroup.enter()
        run(after: 2) {
            print("Set1 Download complete")
            self.datas.append(contentsOf: self.dataSet1)
            self.dispatchGroup.leave()
        }
    }

    func getDataSet2() {
        dispatchGroup.enter()
        run(after: 2) {
            print("Set2 Download complete")
            self.datas.append(contentsOf: self.dataSet2)
            self.dispatchGroup.leave()
        }
    }
    
    func getDataSet3() {
        dispatchGroup.enter()
        run(after: 2) {
            print("Set3 Download complete")
            self.datas.append(contentsOf: self.dataSet3)
            self.dispatchGroup.leave()
        }
    }
    func getDataSet4() {
        dispatchGroup.enter()
        run(after: 4) {
            print("Set4 Download complete")
            self.datas.append(contentsOf: self.dataSet1)
            self.dispatchGroup.leave()
        }
    }
    func getDataSet5() {
        dispatchGroup.enter()
        run(after: 4) {
            print("Set5 Download complete")
            self.datas.append(contentsOf: self.dataSet1)
            self.dispatchGroup.leave()
        }
    }
    
    func showData() {
        print("reloading data")
        tableView.reloadData()
    }
    @IBAction func downloadDataPressed(_ sender: Any) {
        
        print("downloading")
        getDataSet1()
        getDataSet2()
        getDataSet3()
        getDataSet4()
        getDataSet5()
        
        dispatchGroup.notify(queue: .main) {
            self.showData()
        }
    }
}


extension LoadDataVC : UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datas.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
            cell.textLabel?.text = datas[indexPath.row]
            return cell
    }
    
    
}








