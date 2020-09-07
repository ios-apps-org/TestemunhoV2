import UIKit
import MapKit
import CloudKit
import CoreLocation

class Establishment {
  
    enum ChangingTable: Int {
        case none
        case womens
        case mens
        case both
    }
  
    static let recordType = "Establishment"
    private let id: CKRecord.ID
    let name: String
    let location: CLLocation
    let coverPhoto: CKAsset?
    let database: CKDatabase
    let changingTable: ChangingTable
    let kidsMenu: Bool
    let healthyOption: Bool
    private(set) var notes: [Note]? = nil
  
    init?(record: CKRecord, database: CKDatabase) {
        guard
            let name = record["name"] as? String,
            let location = record["location"] as? CLLocation
            else { return nil }
    
        id = record.recordID
        self.name = name
        self.location = location
        coverPhoto = record["coverPhoto"] as? CKAsset
        self.database = database
        healthyOption = record["healthyOption"] as? Bool ?? false
        kidsMenu = record["kidsMenu"] as? Bool ?? false
    
        if let changingTableValue = record["changingTable"] as? Int,
            let changingTable = ChangingTable(rawValue: changingTableValue) {
            self.changingTable = changingTable
        } else {
            self.changingTable = .none
        }
      
        // Note: line 48
        if let noteRecords = record["notes"] as? [CKRecord.Reference] {
            Note.fetchNotes(for: noteRecords) { notes in
                self.notes = notes
            }
        }
    }

    func loadCoverPhoto(completion: @escaping (_ photo: UIImage?) -> ()) {

        DispatchQueue.global(qos: .utility).async {
            var image: UIImage?
            defer {
                DispatchQueue.main.async {
                    completion(image)
                }
            }

            guard let coverPhoto = self.coverPhoto, let fileURL = coverPhoto.fileURL
            else { return }
          
            let imageData: Data
            do {

                imageData = try Data(contentsOf: fileURL)
            } catch {
                return
            }

            image = UIImage(data: imageData)
        }
    }
}

extension Establishment: Hashable {
  
    static func == (lhs: Establishment, rhs: Establishment) -> Bool {
        return lhs.id == rhs.id
    }
  
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
