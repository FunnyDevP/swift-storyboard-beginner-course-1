//
//  DetailViewController.swift
//  Fortune
//
//  Created by Funny Dev on 2/2/22.
//

import UIKit

class DetailViewController: UIViewController {
    var fortuneDetail:String?
    override func viewDidLoad() {
        super.viewDidLoad()
        label.text = fortuneDetail
        label.numberOfLines = 0
        label.font = UIFont.italicSystemFont(ofSize: 18.0)
        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var label: UILabel!
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
