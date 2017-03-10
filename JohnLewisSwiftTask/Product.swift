import Foundation
import SwiftyJSON

public class Product: NSObject {
    
    var id:String;
    var price:String;
    var title:String;
    var imageUrl:URL;
    
    init(withProduct product: JSON) {
        self.id = product["productId"].string != nil ? product["productId"].string! : "";
        self.title = product["title"].string != nil ? product["title"].string! : "";
        self.price = product["price"] != JSON.null ? product["price"]["now"].string! : "";
        self.imageUrl = product["media"] == JSON.null ? URL(string:product["image"].string!)! : URL(string: "//www.sitehawk.com/wp-content/uploads/2015/08/placeholder.jpg")!;
    }
}

