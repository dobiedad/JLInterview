import Foundation
import SwiftyJSON

class Lists: NSObject {
    
    open func list(ofProducts array: [JSON]) -> Array<Any> {
        
        var converted = Array<Any>()
        
        for i in 0..<array.count {
            let product = Product.init(withProduct: array[i] as JSON)
            converted.insert(product, at: i)
            
        }
        return converted
    }
    
}

