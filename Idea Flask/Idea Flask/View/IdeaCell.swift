//
//  IdeaCell.swift
//  Idea Flask
//
//  Created by Allbee, Eamon on 7/22/19.
//  Copyright © 2019 Allbee, Eamon. All rights reserved.
//

import UIKit

class IdeaCell: UITableViewCell {

    @IBOutlet weak var lblIdeaDescription: UILabel!
    
    @IBOutlet weak var lblIdeaDate: UILabel!
    
    @IBOutlet weak var lblIdeaText: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func updateViews(idea: Idea) {
        lblIdeaDescription.text = idea.ideaTagline
        lblIdeaDate.text = "today"
        lblIdeaText.text = idea.ideaNotes
    }
    
}
