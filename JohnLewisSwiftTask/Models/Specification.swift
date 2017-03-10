import Foundation
import SwiftyJSON

public class Specification: NSObject {
    
    var value:String;
    var name:String;
    
    
    init(withData data: JSON) {
        self.value = data["value"].string != nil ? data["value"].string! : "";
        self.name = data["name"].string != nil ? data["name"].string! : "";
    }
}

