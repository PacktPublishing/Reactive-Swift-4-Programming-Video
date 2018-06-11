//
//  FavouritesViewController.swift
//  rxswiftcourse
//
//  Created by James Saeed on 30/03/2018.
//  Copyright © 2018 James Saeed. All rights reserved.
//

import UIKit
import Firebase

class FavouritesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var ref: DatabaseReference!
    var favouriteMovies = [String]() {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = Database.database().reference()
        
        ref.child("favourites").observeSingleEvent(of: .value) { snapshot in
            for child in snapshot.children.allObjects as! [DataSnapshot] {
                let favouriteMovieDict = child.value as? [String : String] ?? [:]
                
                if let favouriteMovie = favouriteMovieDict["movie-title"] {
                    self.favouriteMovies.append(favouriteMovie)
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favouriteMovies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "favouriteCell")
        
        cell?.textLabel?.text = favouriteMovies[indexPath.row]
        
        return cell!
    }
}
