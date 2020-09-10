import UIKit

class ResidentPayViewController: UIViewController {

    @IBOutlet weak var fileName : UITextField!
    
    var residentPayViewModel : ResidentPayViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Generar informe"
        fileName.becomeFirstResponder()
        residentPayViewModel = ResidentPayViewModel()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func generateFile() {
        
        if fileName.text?.count == 0 {
            showAlert(text: "Ingrese el nombre del archivo")
            return
        }
        
        residentPayViewModel?.sumDurationMonth(fileName: fileName.text!)
        showAlert(text: "El archivo fue generado")
    }
    
    func showAlert(text: String) {
        let alert = UIAlertController(title: "", message: text, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Aceptar", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
}
