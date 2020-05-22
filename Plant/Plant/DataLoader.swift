//
//  DataLoader.swift
//  Plant
//
//  Created by Michael Park on 5/22/20.
//  Copyright © 2020 Michael Park. All rights reserved.
//

import SwiftUI

public class DataLoader: ObservableObject {
    @Published var data = [SensorData]()
    
    init(){
        load()
    }
    
    func load() {
        
        let url = URL(string: "https://json-data11954-xcode.s3-us-west-2.amazonaws.com/2020-05-18.json")!
        let configuration = URLSessionConfiguration.ephemeral //background(withIdentifier: "com.jsonData.refesh)
        let session = URLSession(configuration: configuration)
        session.dataTask(with: url) {(data,response,error) in
            do {
                if let d = data {
                    let decodedLists = try JSONDecoder().decode([SensorData].self, from: d)
                    DispatchQueue.main.async {
                        self.data = decodedLists
                        print(decodedLists[0])
                    }
                }else {
                    print("No Data")
                }
            } catch {
                print ("Error")
            }
            
        }.resume()
         
    }
}