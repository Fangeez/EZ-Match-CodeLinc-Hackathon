import UIKit
class NotifViewController: UIViewController, UITableViewDelegate {
    
    let animals: [String] = ["Horse", "Cow", "Camel", "Sheep", "Goat"]
    let cellReuseIdentifier = "cell"
    
    let tableView = UITableView()
    
    var safeArea: UILayoutGuide!
    var characters = ["Link", "Zelda", "Ganondorf", "Midna"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTableView()
        

        
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func setUpTableView(){
        self.view.addSubview(tableView)
            tableView.translatesAutoresizingMaskIntoConstraints = false
            tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
          }
    }


extension NotifViewController: UITableViewDataSource {
    
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return characters.count
  }
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
    cell.textLabel?.text = characters[indexPath.row]
    return cell
  }
}
