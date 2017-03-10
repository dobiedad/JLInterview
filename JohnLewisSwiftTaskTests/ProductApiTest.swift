import XCTest
import SwiftyJSON

@testable import JohnLewisSwiftTask

class ProductAPITest: XCTestCase {
    
    func testFetchProducts() {
        let exp = expectation(description: "Fetches products for the grid")
        let api = ProductAPI()
        var products:Array<Any> = [];
        
        api.loadAllProducts { (result) in
            print(result)
            products = result ;
            exp.fulfill()
        }
        
        self.waitForExpectations(timeout: 5) { error in
            XCTAssertNil(error, "Error")
            XCTAssertGreaterThan((products[0] as! Product).title.characters.count, 0)
            XCTAssertGreaterThan((products[0] as! Product).id.characters.count, 0)
            XCTAssertGreaterThan((products[0] as! Product).price.characters.count, 0)
            XCTAssertEqual(products.count, 20)
        }
    }
    
    func testFetchMoreDetailsForProduct() {
        let exp = expectation(description: "Fetches product details")
        let api = ProductAPI()
        var products:Array<Any> = [];
        
        api.loadAllProducts { (res) in
            api.fetchMoreDetailsForProductWith(id: (res[0] as AnyObject).id) { (result) in
                print(result)
                products.insert(result, at: 0)
                exp.fulfill()
            }
        }
        
        self.waitForExpectations(timeout: 55) { error in
            XCTAssertNil(error, "Error")
            XCTAssertGreaterThan((products[0] as! Product).info.characters.count, 0)
            XCTAssertGreaterThan((products[0] as! Product).code.characters.count, 0)
            XCTAssertGreaterThan((products[0] as! Product).specs.count, 0)
            XCTAssertGreaterThan((products[0] as! Product).media.urls.count, 0)
        }
    }
}
