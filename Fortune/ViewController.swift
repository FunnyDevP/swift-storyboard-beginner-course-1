//
//  ViewController.swift
//  Fortune
//
//  Created by Funny Dev on 2/2/22.
//

import UIKit

struct FortuneData {
    var id: UUID = UUID()
    var message: String
}
class ViewController: UIViewController, UITableViewDataSource {
    
    var fortunes: [FortuneData] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        textView.layer.borderColor = UIColor.systemPink.cgColor
        textView.layer.borderWidth = 1
        textView.layer.cornerRadius = 8
        textView.text = ""
        textView.becomeFirstResponder()
        
        tableView.dataSource = self
        fortuneBT.isEnabled = false
        
        
    }
    
    // MARK: - Outlet
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var fortuneBT: UIButton!
    
    // MARK: - Action
    @IBAction func addNewFortuneBT(_ sender: Any) {
        let newFortune = FortuneData(message: textView.text)
        
        let newRowIndex = fortunes.count
        fortunes.append(newFortune)
        
        // add new row
        let indexPath = IndexPath(row: newRowIndex, section: 0)
        let indexPaths = [indexPath]
        tableView.insertRows(at: indexPaths, with: .automatic)
        textView.text = ""
        fortuneBT.isEnabled = true
    }
    @IBAction func fortuneBT(_ sender: Any) {
        var randomFortune = ""
        if fortunes.count > 0 {
            randomFortune = fortunes[Int.random(in: 0..<fortunes.count)].message
        }
        let alert = UIAlertController(title: "Your fortune is ...", message: "\(randomFortune)", preferredStyle: .alert)
        
        let alertActionDone = UIAlertAction(title: "Done", style: .default){_ in
            
            // navigation to detail screen
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let ctrl = storyboard.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
            ctrl.fortuneDetail = randomFortune
            
            self.navigationController?.pushViewController(ctrl, animated: true)
        }
        
        let alertActionAgain = UIAlertAction(title: "Again!", style: .destructive) { _ in
            randomFortune = self.fortunes[Int.random(in: 0..<self.fortunes.count)].message
            alert.message = randomFortune
            self.present(alert, animated: true, completion: nil)
        }
        
        alert.addAction(alertActionDone)
        alert.addAction(alertActionAgain)
        
        present(alert, animated: true, completion: nil)
    }
    
    
    // MARK: - Table view datasource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fortunes.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "homeFortune", for: indexPath)
        let fortune = fortunes[indexPath.row]
        
        // set content for individual cell
        var content = cell.defaultContentConfiguration()
        content.text = fortune.message
        content.textProperties.numberOfLines = 2
        content.textProperties.lineBreakMode = .byTruncatingTail
        cell.contentConfiguration = content
        return cell
    }
    
    
    // MARK: - Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToDetail" {
            let ctrl = segue.destination as! DetailViewController
            let currentSelectedRow = tableView.indexPathForSelectedRow?.row ?? 0
            
            ctrl.fortuneDetail = fortunes[currentSelectedRow].message
        }
    }
    
}

