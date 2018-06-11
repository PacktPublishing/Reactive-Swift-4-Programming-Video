//
//  ViewController.swift
//  rxswiftcourse
//
//  Created by James Saeed on 28/01/2018.
//  Copyright © 2018 James Saeed. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Alamofire
import SwiftyJSON
import Firebase

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var movieSearch: UISearchBar!
    
    var ref: DatabaseReference!
    var movies = [String]() {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = Database.database().reference()
        
        movieSearch.rx.text
            .orEmpty
            .distinctUntilChanged()
            .filter{ !$0.isEmpty }
            .debounce(0.5, scheduler: MainScheduler.instance)
            .subscribe(onNext: { query in
                let url = "https://www.omdbapi.com/?apikey=" + Values.key + "&s=" + query
                
                Alamofire.request(url).responseJSON(completionHandler: { response in
                    if let value = response.result.value {
                        let json = JSON(value)
                        
                        self.movies.removeAll()
                        
                        for movie in json["Search"] {
                            if let title = movie.1["Title"].string {
                                self.movies.append(title)
                            }
                        }
                    }
                })
            })
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        
        cell?.textLabel?.text = movies[indexPath.row]
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedMovie = movies[indexPath.row]
        
        ref.child("favourites").childByAutoId().setValue(["movie-title" : selectedMovie])
    }
}
