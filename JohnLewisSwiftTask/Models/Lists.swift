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
    
    open func list(ofSpecifications array: Array<Any>) -> Array<Any> {
        
        var converted = Array<Any>()
        
        for i in 0..<array.count {
            let spec = Specification.init(withData: array[i] as! JSON)
            converted.insert(spec, at: i)
            
        }
        return converted
    }
}

