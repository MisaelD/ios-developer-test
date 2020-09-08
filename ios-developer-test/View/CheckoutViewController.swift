import UIKit

class CheckoutViewController: UIViewController {

    @IBOutlet weak var licensePlateTV : UITextField!
    
    var checkoutViewModel : CheckoutViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Registrar salida"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Checkout", style: .plain, target: self, action: #selector(checkoutButton))
        checkoutViewModel = CheckoutViewModel()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @objc func checkoutButton() {
        checkout()
    }
    
    func checkout() {
        
        if licensePlateTV.text?.count == 0 {
            showAlert(text: "Ingrese la placa del automóvil")
            return
        }
        
        let success = checkoutViewModel?.updateLicensePlate(licensePlate: licensePlateTV.text!)
        
        if success! {
            if let navController = self.navigationController {
                navController.popViewController(animated: true)
            }
        }else{
            showAlert(text: "No se encontró un registro que coincida con la placa")
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
}
