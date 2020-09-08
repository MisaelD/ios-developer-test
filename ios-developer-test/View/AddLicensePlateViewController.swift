import UIKit

class AddLicensePlateViewController: UIViewController {
    
    @IBOutlet weak var licensePlateTV : UITextField!
    
    var addLicensePlateViewModel : AddLicensePlateViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Registrar entrada"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Guardar", style: .plain, target: self, action: #selector(saveButton))
        addLicensePlateViewModel = AddLicensePlateViewModel()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @objc func saveButton() {
        saveLicensePlate()
    }
    
    func saveLicensePlate() {
        
        if licensePlateTV.text?.count == 0 {
            showAlert(text: "Ingrese la placa del automóvil")
            return
        }
        
        let success = addLicensePlateViewModel?.updateLicensePlate(licensePlate: licensePlateTV.text!)
        
        if success! {
            if let navController = self.navigationController {
                navController.popViewController(animated: true)
            }
        }else {
            showAlert(text: "No se encontró un registro que coincida con la placa")
        }
    }

    func showAlert(text: String) {
        let alert = UIAlertController(title: "", message: text, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Aceptar", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
}

extension AddLicensePlateViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        saveLicensePlate()
        return true
    }
}
