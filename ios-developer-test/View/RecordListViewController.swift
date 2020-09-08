import UIKit

class RecordListViewController: UIViewController {

    @IBOutlet weak var table : UITableView!
    
    var recordListViewModel : RecordListViewModel?
    var recordsList : [LicensePlateModel]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Registros"
        recordListViewModel = RecordListViewModel()
        recordsList = recordListViewModel?.fechtRecords()
        //dump(recordsList?[0].placa)
        table.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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
        cell.licensePlate.text = recordsList?[indexPath.row].placa
        cell.tipo.text = recordsList?[indexPath.row].tipo
        cell.entradaFecha.text = recordsList?[indexPath.row].entradaDateFormated()
        cell.salidaFecha.text = recordsList?[indexPath.row].salidaDateFormated()
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
