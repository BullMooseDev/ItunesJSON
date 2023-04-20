
import UIKit

@MainActor
class StoreItemListTableViewController: UITableViewController {
    
    var storeItemController = StoreItemController()
    
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var filterSegmentedControl: UISegmentedControl!
    
    var items = [StoreItem]()
    var imageLoadTasks: [IndexPath: Task<Void, Never>] = [:]
    
    let queryOptions = ["movie", "music", "software", "ebook"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func fetchMatchingItems() {
        
        self.items = []
        self.tableView.reloadData()
        
        let searchTerm = searchBar.text ?? ""
        let mediaType = queryOptions[filterSegmentedControl.selectedSegmentIndex]
        
        if !searchTerm.isEmpty {
            
            let query = [
                "term": searchTerm,
                "media": mediaType,
                "limit": "2"
            ]
                    
            fetchItems(matching: query)
        }
    }
    
    func fetchItems(matching: [String: String]) {
        Task {
            do {
                let fetchedItems = try await storeItemController.fetchItems(matching: matching)
                self.items = fetchedItems
                self.tableView.reloadData()
            } catch {
                print(error)
            }
        }
    }
    
    func configure(cell: ItemCell, forItemAt indexPath: IndexPath) {
        
        let item = items[indexPath.row]
        
        // set cell.name to the item's name
        cell.name = item.name
        
        // set cell.artist to the item's artist
        cell.artist = item.artist
        
        let imageURL = item.artworkURL
        cell.loadImage(from: imageURL, defaultImage: "default")
    }
    
    @IBAction func filterOptionUpdated(_ sender: UISegmentedControl) {
        fetchMatchingItems()
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if items.isEmpty {
            return 0
        }
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Item", for: indexPath) as! ItemCell
        configure(cell: cell, forItemAt: indexPath)
        
        return cell
    }
    
    // MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        // cancel the image fetching task if we no longer need it
        imageLoadTasks[indexPath]?.cancel()
    }
}

extension StoreItemListTableViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        fetchMatchingItems()
        searchBar.resignFirstResponder()
    }
    
//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        fetchMatchingItems()
//    }
}
