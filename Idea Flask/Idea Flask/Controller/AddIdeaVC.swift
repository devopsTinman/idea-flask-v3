//
//  AddIdeaVC.swift
//  Idea Flask
//
//  Created by Allbee, Eamon on 7/21/19.
//  Copyright © 2019 Allbee, Eamon. All rights reserved.
//

import UIKit

class AddIdeaVC: UIViewController {
    @IBOutlet weak var txtIdeatag: UITextField!
    @IBOutlet weak var txtIdeaText: UITextView!
    
    @IBAction func saveBtnPressed(_ sender: Any) {
        
        let newIdea = Idea(ideaCategory: "Apps", ideaNotes: txtIdeaText.text, ideaTagline: txtIdeatag.text!, user: "me", ideaID: UUID().uuidString, dateAdded: Date())
        DataService.instance.saveIdea(idea: newIdea)
        dismiss(animated: true, completion: nil)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
