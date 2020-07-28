//
//  ViewController.swift
//  Films
//
//  Created by Владимир Коваленко on 28.07.2020.
//  Copyright © 2020 Vladimir Kovalenko. All rights reserved.
//

import UIKit

class FilmListViewController: UITableViewController {
    
    var results = [FilmResults]()
    let url = URL(string: "https://api.themoviedb.org/3/discover/movie?api_key=b465eb301c62ac9bf545530e8b39ff5c&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=1&year=2019&vote_average.gte=7")
    override func viewDidLoad() {
        super.viewDidLoad()
        downloadData()
        tableView.rowHeight = 300
        
    }
    
// MARK: - TableView Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FilmCell") as! FilmTableViewCell
        let urlImage = "https://image.tmdb.org/t/p/original\(results[indexPath.row].poster_path)"
        cell.titleLabel.text = results[indexPath.row].title
        cell.overviewText.text = results[indexPath.row].overview
        cell.pubDateLabel.text = results[indexPath.row].release_date
        
        if let imageURL = URL(string: urlImage) {
                   DispatchQueue.global().async {
                       let data = try? Data(contentsOf: imageURL)
                       if let data = data {
                           let image = UIImage(data: data)
                           DispatchQueue.main.async {
                            cell.filmPoster.image = image
                       }
                   }
               }
          }
        
        
        let voteAverage = results[indexPath.row].vote_average
        let voteAveregeString = String(format: "%.1f", voteAverage)
        cell.voteAverageLabel.text = voteAveregeString
        return cell
    }
}
// MARK: - parsing Json and getting data
extension FilmListViewController {
    
    func downloadData() {
             guard let downloadURL = url else { return }
             URLSession.shared.dataTask(with: downloadURL) { data, urlResponse, error in
                 guard let data = data, error == nil, urlResponse != nil else {
                     print("something is wrong")
                     return
                 }
                 print("downloaded")
                 do
                 {
                     let decoder = JSONDecoder()
                     let decodeData = try decoder.decode(DataResults.self, from: data)
                    self.results = decodeData.results
                     DispatchQueue.main.async {
                         self.tableView.reloadData()
                       print(self.results)
                     }
                 } catch {
                     print("something wrong after downloaded:\(error)")
                 }
             }.resume()
         }
}

