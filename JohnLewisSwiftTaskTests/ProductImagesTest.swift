import XCTest
import SwiftyJSON

@testable import JohnLewisSwiftTask

class ProductImagesTest: XCTestCase {
    
    func testInitWithProductImages() {
        let exp = expectation(description: "Loaded Product From Data")
        
        let data = [JSON("google.co.uk"),JSON("google.com")]
        
        let images = ProductImages(withData:data);
        
        exp.fulfill()
        
        self.waitForExpectations(timeout: 1) { error in
            XCTAssertNil(error, "Error")
            XCTAssertEqual(images.urls.count, 2)
        }
    }
}
