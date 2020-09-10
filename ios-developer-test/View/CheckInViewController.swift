import UIKit

class CheckInViewController: UIViewController {
    
    @IBOutlet weak var licensePlateTV : UITextField!
    
    var checkInViewModel : CheckInViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Registrar entrada"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Guardar", style: .plain, target: self, action: #selector(saveButton))
        licensePlateTV.delegate = self
        licensePlateTV.placeholder = "Placa"
        licensePlateTV.becomeFirstResponder()
        checkInViewModel = CheckInViewModel()
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
        
        let success = checkInViewModel?.checkInVehicle(licensePlate: licensePlateTV.text!)
        switch success! {
        case .recordNoExist:
            showAlert(text: "No se encontró un registro que coincida con la placa del vehículo")
        case .parked:
            showAlert(text: "El vehículo esta en el estacionamiento")
        case .error:
            showAlert(text: "Hubo algun problema, inténtelo de nuevo")
        case .success:
            if let navController = self.navigationController {
                navController.popViewController(animated: true)
            }
        default:
            break
        }
    }
    
    func showAlert(text: String) {
        let alert = UIAlertController(title: "", message: text, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Aceptar", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
}

extension CheckInViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        saveLicensePlate()
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        textField.text = (textField.text! as NSString).replacingCharacters(in: range, with: string.uppercased())
        
        return false
    }
}
