import UIKit

class FileTxtManager: NSObject {

    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    func generateFileAndWrite(fileName: String, dictionary: [NSDictionary]) {
        let filename = getDocumentsDirectory().appendingPathComponent("\(fileName).txt")
        
        var outputString = "Núm. Placa".padding(length: 15) + "Tiempo estacionado (min)".padding(length: 29) + "Cantidad a pagar\n"
        
        for d in dictionary {
            let timeParking = d["sum"] as! Float
            outputString += String(describing: d["placa"]!).padding(length: 15) + String(format: "%.2f", timeParking).padding(length: 29) + String(format: "$%.2f", timeParking * 0.05) + "\n"
        }
        
        do {
            try outputString.write(to: filename, atomically: true, encoding: String.Encoding.utf8)
        } catch {}
    }
}
