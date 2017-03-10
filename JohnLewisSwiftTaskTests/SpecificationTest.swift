import XCTest
import SwiftyJSON

@testable import JohnLewisSwiftTask

class SpecificationTest: XCTestCase {
    
    func testInitWithSpec() {
        let exp = expectation(description: "Loaded Spec From Data")
        
        let json = JSON(["name":JSON("Waterproof"), "value": JSON("Yes")])
        
        let spec = Specification(withData:json)
        
        exp.fulfill()
        
        self.waitForExpectations(timeout: 1) { error in
            XCTAssertNil(error, "Error")
            XCTAssertGreaterThan(spec.value.characters.count, 0)
            XCTAssertGreaterThan(spec.name.characters.count, 0)
        }
    }
}
