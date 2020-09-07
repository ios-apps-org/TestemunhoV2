import Foundation
import CloudKit

class Note {
  
    private let id: CKRecord.ID
    private(set) var noteLabel: String?
  
    let establishmentReference: CKRecord.Reference?

    init(record: CKRecord) {
        id = record.recordID
        noteLabel = record["text"] as? String
        establishmentReference = record["establishment"] as? CKRecord.Reference
    }
  
    static func fetchNotes(_ completion: @escaping (Result<[Note], Error>) -> Void) {
      
        let query = CKQuery(recordType: "Note",
                          predicate: NSPredicate(value: true))
      
        let container = CKContainer.default()
      
        container.privateCloudDatabase.perform(query, inZoneWith: nil) { results, error in
        
            if let error = error {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
                return
            }
            
            guard let results = results else {
                DispatchQueue.main.async {
                    let error = NSError(domain: "com.jdemaagd", code: -1, userInfo: [NSLocalizedDescriptionKey: "Could not download notes"])
                    completion(.failure(error))
                }
                return
            }

            let notes = results.map(Note.init)
            DispatchQueue.main.async {
                completion(.success(notes))
            }
        }
    }
  
    static func fetchNotes(for references: [CKRecord.Reference],
                           _ completion: @escaping ([Note]) -> Void) {
        let recordIDs = references.map { $0.recordID }
        let operation = CKFetchRecordsOperation(recordIDs: recordIDs)
        operation.qualityOfService = .utility
      
        operation.fetchRecordsCompletionBlock = { records, error in
            let notes = records?.values.map(Note.init) ?? []
            DispatchQueue.main.async {
                completion(notes)
            }
        }
      
        Model.currentModel.privateDB.add(operation)
    }
}

extension Note: Hashable {
  
    static func == (lhs: Note, rhs: Note) -> Bool {
        return lhs.id == rhs.id
    }
  
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
