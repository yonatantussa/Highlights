import UIKit
import CoreData

var highlightList = [Highlight]()

class HighlightTableView: UITableViewController {
    var firstLoad = true
    
    func nonDeletedHighlights() -> [Highlight] {
        var nonDeletedHighlightList = [Highlight]()
        for highlight in highlightList {
            if(highlight.deletedDate == nil) {
                nonDeletedHighlightList.append(highlight)
            }
        }
        
        return nonDeletedHighlightList
    }
    
    override func viewDidLoad() {
        if(firstLoad) {
            firstLoad = false
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Highlight")
            do {
                let results:NSArray = try context.fetch(request) as NSArray
                for result in results {
                    let highlight = result as! Highlight
                    highlightList.append(highlight)
                }
            } catch {
                print("Fetch Failed")
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let highlightCell = tableView.dequeueReusableCell(withIdentifier: "highlightCellID", for: indexPath) as! HighlightCell
        
        let thisHighlight: Highlight!
        thisHighlight = nonDeletedHighlights()[indexPath.row]
        
        highlightCell.titleLabel.text = thisHighlight.title
        highlightCell.descLabel.text = thisHighlight.desc
        
        return highlightCell
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nonDeletedHighlights().count
    }
    
    override func viewDidAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "editHighlight", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "editHighlight") {
            let indexPath = tableView.indexPathForSelectedRow!
            
            let highlightDetail = segue.destination as? HighlightDetailVC
            
            let selectedHighlight : Highlight!
            selectedHighlight = nonDeletedHighlights()[indexPath.row]
            highlightDetail!.selectedHighlight = selectedHighlight
            
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
}
