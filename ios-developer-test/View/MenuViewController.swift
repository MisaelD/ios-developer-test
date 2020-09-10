import UIKit

class MenuViewController: UIViewController {

    var menuViewModel : MenuViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Menú"
        menuViewModel = MenuViewModel()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    @IBAction func addLicensePlate(){
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "CheckInViewController") as! CheckInViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func checkout(){
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "CheckoutViewController") as! CheckoutViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func recordList(){
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "RecordListViewController") as! RecordListViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func addVehicle(){
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "AddVehicleViewController") as! AddVehicleViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func vehicleList(){
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "VehicleListViewController") as! VehicleListViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func startMonth(){
        menuViewModel?.startMonth(finished: { success in

            if success {
                showAlert(text: "Se han borrado los registros anteriores")
            } else {
                showAlert(text: "Hubo algun problema, inténtelo de nuevo")
            }
        })
    }
    
    @IBAction func residentsPay(){
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ResidentPayViewController") as! ResidentPayViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }

    func showAlert(text: String) {
        let alert = UIAlertController(title: "", message: text, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Aceptar", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
}
