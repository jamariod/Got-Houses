//
//  Houses.swift
//  Got-Houses
//
//  Created by Jamario Davis on 2/2/21.
//

import Foundation

class Houses {
    
    var houseArray: [HouseInfo] = []
    var url = "https://www.anapioficeandfire.com/api/houses?page=1&pageSize=50"
    var pageNumber = 1
    var continueLoading = true
    
    func getData(completed: @escaping ()->()) {
        let urlString = "https://www.anapioficeandfire.com/api/houses?page=\(pageNumber)&pageSize=50"
        print("We are accessing the url \(urlString)")
        
        // Create a URL
        guard let url = URL(string: urlString) else {
            print("ERROR: Could not create a URL from \(urlString)")
            completed()
            return
        }
        // Create Session
        let session = URLSession.shared
        
        // Get data with .daskTask method
        let task = session.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("ERROR: \(error.localizedDescription)")
            }
            
            // deal with data
            do {
                let results = try JSONDecoder().decode([HouseInfo].self, from: data!)
                // If there is data in the array, increment pageNumber by one and update the houseArray to equal houseArray + our new array
                if results.count > 0 {
                    self.pageNumber = self.pageNumber + 1
                    self.houseArray = self.houseArray + results
                } else {
                    self.continueLoading = false 
                }
                print("this is what we returned from getData: \(self.houseArray)")
            } catch {
                print("JSON ERROR: \(error.localizedDescription)")
            }
            completed()
        }
        task.resume()
    }
}
