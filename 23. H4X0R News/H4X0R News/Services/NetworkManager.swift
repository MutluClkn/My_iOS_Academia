//
//  NetworkManager.swift
//  H4X0R News
//
//  Created by Mutlu Çalkan on 29.11.2022.
//

import Foundation

class NetworkManager: ObservableObject {
    
    @Published var posts = [Post]()
    
    func fetchData(){
        if let url = URL(string: "http://hn.algolia.com/api/v1/search?tags=front_page"){
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, response, error in
                if let error {
                    print(error.localizedDescription)
                }
                if let data {
                    let decoder = JSONDecoder()
                    do {
                        let result = try decoder.decode(Results.self, from: data)
                        DispatchQueue.main.async {
                            self.posts = result.hits
                        }
                    }catch {
                        print(error.localizedDescription)
                    }
                    
                }
            }
            task.resume()
        }
    }
}
