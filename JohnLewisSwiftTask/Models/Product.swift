import Foundation
import SwiftyJSON

public class Product: NSObject {
    
    var id:String;
    var price:String;
    var title:String;
    var imageUrl:URL;
    
    var info:String;
    var code:String;
    var warranty:String;
    var specialOffer:String;
    var specs: Array<Any>;
    var media: ProductImages
    
    init(withProduct product: JSON) {
        self.id = product["productId"].string != nil ? product["productId"].string! : "";
        self.title = product["title"].string != nil ? product["title"].string! : "";
        self.price = product["price"] != JSON.null ? product["price"]["now"].string! : "";
        self.imageUrl = product["media"] == JSON.null ? URL(string:product["image"].string!)! : URL(string: "//www.sitehawk.com/wp-content/uploads/2015/08/placeholder.jpg")!;
        self.info = product["details"]["productInformation"].string != nil ? (product["details"]["productInformation"].string!).replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil) : "";
        self.code = product["code"].string != nil ? product["code"].string! : "";
        self.warranty = product["additionalServices"]["includedServices"][0].string != nil ? product["additionalServices"]["includedServices"][0].string! : "";
        self.specialOffer = product["displaySpecialOffer"].string != nil ? product["displaySpecialOffer"].string! : "";
        self.specs = product["details"]["features"] != JSON.null ? Lists().list(ofSpecifications: product["details"]["features"][0]["attributes"].arrayValue) :[]
        
        
        self.media = product["media"] != JSON.null ? ProductImages(withData:product["media"]["images"]["urls"].array!) : ProductImages(withData:[]);
    }
}

