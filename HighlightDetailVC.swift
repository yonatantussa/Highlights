import UIKit
import CoreData

class HighlightDetailVC: UIViewController {
    

    @IBOutlet weak var titleTF: UITextField!
    @IBOutlet weak var descTV: UITextView!
    
    var selectedHighlight: Highlight? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if(selectedHighlight != nil) {
            titleTF.text = selectedHighlight?.title
            descTV.text = selectedHighlight?.desc
        }
    }


    @IBAction func saveAction(_ sender: Any) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
        if(selectedHighlight == nil) {
            let entity = NSEntityDescription.entity(forEntityName: "Highlight", in: context)
            let newHighlight = Highlight(entity: entity!, insertInto: context)
            newHighlight.id = highlightList.count as NSNumber
            newHighlight.title = titleTF.text
            newHighlight.desc = descTV.text
            do {
                try context.save()
                highlightList.append(newHighlight)
                navigationController?.popViewController(animated: true)
            } catch {
                print("context save error")
            }
        } else {
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Highlight")
            do {
                let results:NSArray = try context.fetch(request) as NSArray
                for result in results {
                    let highlight = result as! Highlight
                    if(highlight == selectedHighlight) {
                        highlight.title = titleTF.text
                        highlight.desc = descTV.text
                        try context.save()
                        navigationController?.popViewController(animated: true)
                    }
                }
            } catch {
                print("Fetch Failed")
            }
        }
    }
    
    @IBAction func DeleteHighlight(_ sender: Any) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Highlight")
        do {
            let results:NSArray = try context.fetch(request) as NSArray
            for result in results {
                let highlight = result as! Highlight
                if(highlight == selectedHighlight) {
                    highlight.deletedDate = Date()
                    try context.save()
                    navigationController?.popViewController(animated: true)
                }
            }
        } catch {
            print("Fetch Failed")
        }
    }
}

