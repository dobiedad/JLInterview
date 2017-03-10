import XCTest
import SwiftyJSON

@testable import JohnLewisSwiftTask

class ProductTest: XCTestCase {
    
    func testInitWithProduct() {
        let exp = expectation(description: "Loaded Product From Data")
        
        let json = JSON(["productId":"123", "price": ["now":"25.00"],"title":"123", "image":"google.com" ])
        
        let product = Product(withProduct:json)
        
        exp.fulfill()
        
        self.waitForExpectations(timeout: 1) { error in
            XCTAssertNil(error, "Error")
            XCTAssertGreaterThan(product.title.characters.count, 0)
            XCTAssertGreaterThan(product.id.characters.count, 0)
            XCTAssertGreaterThan(product.price.characters.count, 0)
            XCTAssertGreaterThan(product.imageUrl.path.characters.count, 0)
        }
    }
}
