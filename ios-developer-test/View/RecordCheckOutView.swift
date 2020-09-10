import UIKit

class RecordCheckOutView: UIView {

    @IBOutlet weak var vehicleType: UILabel!
    @IBOutlet weak var licensePlate: UILabel!
    @IBOutlet weak var timeCheckIn: UILabel!
    @IBOutlet weak var timeCheckOut: UILabel!
    @IBOutlet weak var payment: UILabel!
    
    func dataParkStay(estancia: Estancia) {
        self.isHidden = false
        vehicleType.text = estancia.ofPlaca?.tipo
        licensePlate.text = estancia.ofPlaca?.placa
        timeCheckIn.text = estancia.entradaDateFormated()
        timeCheckOut.text = estancia.salidaDateFormated()
        payment.text = estancia.importe()
    }
}
