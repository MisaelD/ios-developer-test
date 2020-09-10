import UIKit

class VehicleListViewController: UIViewController {

    @IBOutlet weak var table : UITableView!
    @IBOutlet weak var segmentedControl : UISegmentedControl!
    
    var vehicleListViewModel : VehicleListViewModel?
    var vehiclesList : [Placa]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Vehículos"
        vehicleListViewModel = VehicleListViewModel()
        vehiclesList = vehicleListViewModel?.fechtVehicles(type: "Oficial")
        table.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func typeVehicle() {
        vehiclesList = vehicleListViewModel?.fechtVehicles(type:
            segmentedControl.titleForSegment(at: segmentedControl.selectedSegmentIndex)!)
        table.reloadData()
    }
}

extension VehicleListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (vehiclesList?.count)!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 121
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "VehicleListTableViewCell", for: indexPath) as! VehicleListTableViewCell
        cell.licensePlate.text = vehiclesList?[indexPath.row].placa
        return cell
    }
}
