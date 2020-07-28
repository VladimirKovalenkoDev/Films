//
//  FilmTableViewCell.swift
//  Films
//
//  Created by Владимир Коваленко on 28.07.2020.
//  Copyright © 2020 Vladimir Kovalenko. All rights reserved.
//

import UIKit

class FilmTableViewCell: UITableViewCell {

    @IBOutlet weak var filmPoster: UIImageView!
    @IBOutlet weak var voteAverageLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var pubDateLabel: UILabel!
    
    @IBOutlet weak var calendarButton: UIButton!
    @IBOutlet weak var overviewText: UITextView!
    override func awakeFromNib() {
        super.awakeFromNib()
    
    }
    
    @IBAction func calendarButtonPressed(_ sender: UIButton) {
        
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
