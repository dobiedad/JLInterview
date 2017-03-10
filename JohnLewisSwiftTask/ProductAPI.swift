import Foundation
import Alamofire
import SwiftyJSON

class ProductAPI: NSObject {
    
    open func loadAllProducts(completion: @escaping (_ result: Array<Any>)->()) {
        
        Alamofire.request("https://api.johnlewis.com/v1/products/search?q=dishwasher&key=Wu1Xqn3vNrd1p7hqkvB6hEu0G9OrsYGb&pageSize=20").response { response in
            
            let json = JSON(data: response.data!)
            let products = json["products"]
            
            let productList = Lists().list(ofProducts: products.array!) as Array
            
            return completion((productList as Array))
            
        }
    }
}

