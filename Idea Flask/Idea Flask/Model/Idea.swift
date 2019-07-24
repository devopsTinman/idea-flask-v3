//
//  Idea.swift
//  Idea Flask
//
//  Created by Allbee, Eamon on 7/21/19.
//  Copyright © 2019 Allbee, Eamon. All rights reserved.
//

import Foundation
struct Idea {
    private(set) public var ideaCategory: String
    private(set) public var ideaID: String
    private(set) public var ideaNotes: String
    private(set) public var ideaTagline: String
    private(set) public var user: String
    private(set) public var dateAdded: Date
    
    init(ideaCategory: String, ideaNotes: String, ideaTagline: String, user: String, ideaID: String, dateAdded: Date) {
        self.ideaCategory = ideaCategory
        self.ideaNotes = ideaNotes
        self.ideaTagline = ideaTagline
        self.user = user
        self.ideaID = ideaID
        self.dateAdded = dateAdded
    }
    
    
}
