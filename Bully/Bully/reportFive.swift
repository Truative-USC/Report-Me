
import UIKit

class reportFive: UIViewController {

    @IBOutlet weak var datePickerTxt: UITextField!
    var receiveLocation = String()
    var receiveExtraLocNotes = String()
    var receiveBully = String()
    var receiveBullyNotes = String()
    var firstName = String()
    var firstRole = String()
    var secondName = String()
    var secondRole = String()
    var thirdName = String()
    var thirdRole = String()
    let datePicker = UIDatePicker()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createDatePicker()
        
        // Do any additional setup after loading the view.
    }


    func createDatePicker() {
        //format for picker
        
//        datePicker.datePickerMode = .date
        //toolBar
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        // bar Button Item
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        toolBar.setItems([doneButton], animated: false)
        
        datePickerTxt.inputAccessoryView = toolBar
        
        //assigning datePicker to Text Field
        datePickerTxt.inputView = datePicker
        
    }
    
    
    var sendDate: String = ""
    
    func donePressed() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .short
        
        datePickerTxt.text = dateFormatter.string(from: datePicker.date)
        
        sendDate = dateFormatter.string(from: datePicker.date)
        print(sendDate)
        self.view.endEditing(true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toHome" {
            return
        }
        else {
        
        let finalScreen = segue.destination as! reportSix
        finalScreen.currString = sendDate
        finalScreen.receiveLoc = receiveLocation
        finalScreen.recieveLocNotes = receiveExtraLocNotes
        finalScreen.bullyNotes = receiveBullyNotes
        finalScreen.bullyType = receiveBully
        finalScreen.sendfirstName = firstName
        finalScreen.sendfirstRole = firstRole
        finalScreen.sendsecondRole = secondRole
        finalScreen.sendsecondName = secondName
        finalScreen.sendthirdRole = thirdRole
        finalScreen.sendthirdName = thirdName
        }
    }
    
    
 
    @IBAction func swipeRight(_ sender: UISwipeGestureRecognizer) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func swipeLeft(_ sender: UISwipeGestureRecognizer) {
        self.performSegue(withIdentifier: "lastScreen", sender: self)
    }
    
    @IBAction func quitBtnPressed(_ sender: Any) {
        let alert = UIAlertController(title: "Exit", message: "All Data Will be lost", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action) in
            self.performSegue(withIdentifier: "toHome", sender: self)
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
        }))
        
        self.present(alert, animated: true, completion: nil)

        
    }

}
