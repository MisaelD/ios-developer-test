import UIKit

class AddVehicleViewController: UIViewController {

    @IBOutlet weak var licensePlateTV : UITextField!
    @IBOutlet weak var segmentedControl : UISegmentedControl!
    
    var addVehicleViewModel : AddVehicleViewModel?
    var typeLicense : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Registrar vehículo"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Guardar", style: .plain, target: self, action: #selector(saveButton))
        licensePlateTV.delegate = self
        licensePlateTV.placeholder = "Placa"
        licensePlateTV.becomeFirstResponder()
        addVehicleViewModel = AddVehicleViewModel()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func typeLicensePlate() {
        typeLicense = segmentedControl.titleForSegment(at: segmentedControl.selectedSegmentIndex)
    }
    
    @objc func saveButton() {
        saveVehicle()
    }
    
    func saveVehicle() {
        
        if licensePlateTV.text?.count == 0 {
            showAlert(text: "Ingrese la placa del automóvil")
            return
        }else if typeLicense == nil {
            showAlert(text: "Ingrese el tipo del automóvil")
            return
        }
        
        addVehicleViewModel?.saveVehicle(license: licensePlateTV.text!, tipo: typeLicense!, finished: { success in
            
            if success {
                if let navController = self.navigationController {
                    navController.popViewController(animated: true)
                }
            } else {
                showAlert(text: "Ya ha ingresado la placa del vehículo")
            }
        })
    }
    
    func showAlert(text: String) {
        let alert = UIAlertController(title: "", message: text, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Aceptar", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
}

extension AddVehicleViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        saveVehicle()
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        textField.text = (textField.text! as NSString).replacingCharacters(in: range, with: string.uppercased())
        
        return false
    }
}
