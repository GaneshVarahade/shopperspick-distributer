import Foundation
import Realm
import RealmSwift

public class InvoiceDao: BaseDao<ModelInvoice> {
    
    public override func write<ModelInvoice: Object>(table: ModelInvoice) {
        try! getRealm().write {
            getRealm().add(table.copy() as! ModelInvoice,update: true)
        }
    }
    
    public override func read<ModelInvoice: Object>(primaryKey: String) -> ModelInvoice? {
        
        let model:ModelInvoice? = getRealm().object(ofType: ModelInvoice.self,
                                                    forPrimaryKey: primaryKey)
        
        guard let modelInvoice = model else {
            return nil
        }
        return modelInvoice.copy() as? ModelInvoice
    } 
    
}
