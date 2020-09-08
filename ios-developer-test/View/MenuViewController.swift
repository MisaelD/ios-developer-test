import UIKit

class MenuViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    @IBAction func addLicensePlate(){
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "AddLicensePlateViewController") as! AddLicensePlateViewController
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

}
