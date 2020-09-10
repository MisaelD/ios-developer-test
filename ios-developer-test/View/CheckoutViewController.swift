import UIKit

class CheckoutViewController: UIViewController {

    @IBOutlet weak var licensePlateTV : UITextField!
    @IBOutlet weak var recordCheckOut : RecordCheckOutView!
    
    var checkoutViewModel : CheckoutViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Registrar salida"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Checkout", style: .plain, target: self, action: #selector(checkoutButton))
        licensePlateTV.delegate = self
        licensePlateTV.placeholder = "Placa"
        licensePlateTV.becomeFirstResponder()
        checkoutViewModel = CheckoutViewModel()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @objc func checkoutButton(sender: UIBarButtonItem) {
        sender.isEnabled = false
        checkout()
    }
    
    func checkout() {
        
        if licensePlateTV.text?.count == 0 {
            showAlert(text: "Ingrese la placa del automóvil")
            return
        }
        licensePlateTV.resignFirstResponder()
        licensePlateTV.isEnabled = false
        let result = checkoutViewModel?.checkOutVehicle(licensePlate: licensePlateTV.text!)
        
        switch result!.0 {
        case .recordNoExist:
            showAlert(text: "No se encontró un registro que coincida con la placa del vehículo")
        case .error:
            showAlert(text: "Hubo algun problema, inténtelo de nuevo")
        case .success:
            recordCheckOut.dataParkStay(estancia: (result?.1)!)
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

extension CheckoutViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        checkout()
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        textField.text = (textField.text! as NSString).replacingCharacters(in: range, with: string.uppercased())
        
        return false
    }
}
