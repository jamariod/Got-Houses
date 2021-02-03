//
//  ViewController.swift
//  Got-Houses
//
//  Created by Jamario Davis on 2/2/21.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var houses = Houses()
    var numberOfTimesCalled = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        houses.getData {
            // Add to main queue
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowDetail" {
            let destination = segue.destination as! DetailViewController
            let selectedIndexPath = tableView.indexPathForSelectedRow!
            destination.houseInfo = houses.houseArray[selectedIndexPath.row]
        }
    }
}
extension ViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return houses.houseArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // If you're displaying the very last array in houses.houseArray, then load more.
        if indexPath.row == houses.houseArray.count - 1 && houses.continueLoading {
            houses.getData {
                print("numberOfTimesCalled = \(self.numberOfTimesCalled)")
                self.numberOfTimesCalled += 1
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = "\(indexPath.row + 1). \(houses.houseArray[indexPath.row].name)"
        return cell
    }
}
