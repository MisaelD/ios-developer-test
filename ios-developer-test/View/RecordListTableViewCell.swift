import UIKit

class RecordListTableViewCell: UITableViewCell {

    @IBOutlet weak var licensePlate : UILabel!
    @IBOutlet weak var tipo : UILabel!
    @IBOutlet weak var entradaFecha : UILabel!
    @IBOutlet weak var salidaFecha : UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
