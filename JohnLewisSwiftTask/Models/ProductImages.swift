import Foundation
import SwiftyJSON

public class ProductImages: NSObject {
    
    var urls:Array<Any>;
    
    init(withData data: Array<Any>) {
        var converted = Array<Any>()
        
        for i in 0..<data.count {
            let url = "https:" + (data[i] as! JSON).string!
            converted.insert(url, at: i)
        }
        self.urls = converted;
        
    }
}

