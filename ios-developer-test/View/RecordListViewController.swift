import UIKit

class RecordListViewController: UIViewController {

    @IBOutlet weak var table : UITableView!
    @IBOutlet weak var segmentedControl : UISegmentedControl!
    
    var recordListViewModel : RecordListViewModel?
    var recordsList : [Estancia]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Registros"
        recordListViewModel = RecordListViewModel()
        recordsList = recordListViewModel?.fechtRecords(type: "Oficial")
        table.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func typeVehicle() {
        recordsList = recordListViewModel?.fechtRecords(type:
            segmentedControl.titleForSegment(at: segmentedControl.selectedSegmentIndex)!)
        table.reloadData()
    }
}

extension RecordListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (recordsList?.count)!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 121
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecordListTableViewCell", for: indexPath) as! RecordListTableViewCell
        cell.licensePlate.text = recordsList?[indexPath.row].ofPlaca?.placa
        cell.tipo.text = recordsList?[indexPath.row].ofPlaca?.tipo
        cell.entradaFecha.text = recordsList?[indexPath.row].entradaDateFormated()
        cell.salidaFecha.text = recordsList?[indexPath.row].salidaDateFormated()
        return cell
    }
}
