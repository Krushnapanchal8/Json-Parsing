//
//  ViewController.swift
//  Json-Parsing
//
//  Created by Mac on 10/05/22.
//

import UIKit


class ViewController: UIViewController {
    
    struct Post: Decodable {
        var userId: Int
        var id: Int
        var title: String
        var body: String
    }

    @IBOutlet weak var myTableView: UITableView!
    
    var postArray: [Post] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        parseJson()
    }

    func parseJson() {
        let str = "https://jsonplaceholder.typicode.com/posts"
        let url = URL(string: str)
        
        URLSession.shared.dataTask(with: url!) { data, response, error in
            if error == nil {
                do {
                    self.postArray =  try JSONDecoder().decode([Post].self, from: data!)
                    DispatchQueue.main.async {
                        self.myTableView.reloadData()
                    }
                } catch {
                    print("Something went wrong")
                }
            }
        }.resume()
    }
}

extension ViewController: UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let post = postArray[indexPath.row]
        cell.textLabel?.text = post.title
        cell.detailTextLabel?.text = post.body
        return cell
    }
    
    
}
