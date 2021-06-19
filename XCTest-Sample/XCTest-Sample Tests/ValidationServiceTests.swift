//
//  ValidationServiceTests.swift
//  XCTest-Sample Tests
//
//  Created by Kazunori Aoki on 2021/06/19.
//

@testable import XCTest_Sample
import XCTest

class ValidationServiceTests: XCTestCase {

    var validation: ValidationService!
    
    // setupはテスト実行のたびに呼ぼれる
    // classは消す
    override func setUp() {
        super.setUp()
        validation = ValidationService()
    }
    
    // dispose的な
    // classは消す
    override func tearDown() {
        validation = nil
        super.tearDown()
    }
    
    // testの場合はスネークケースで書く
    // 関数名を網羅する
    func test_is_validate_username() throws {
        // 合格の場合、throwしない関数
        XCTAssertNoThrow(try validation.validateUsername("kilo loco"))
    }
    
    func test_username_is_nil() throws {
        let expectedError = ValidationError.invalidValue
        var error: ValidationError?
        // throwをするかのテスト関数
        XCTAssertThrowsError(try validation.validateUsername(nil)) { thrownError in
            // キャストが必要
            error = thrownError as? ValidationError
        }
        
        // 返却値と比較する
        XCTAssertEqual(expectedError, error)
        
        XCTAssertEqual(expectedError.errorDescription, error?.errorDescription)
    }
    
    func test_username_too_short() throws {
        let expectedError = ValidationError.usernameTooShort
        var error: ValidationError?
        let username = "ki"
        
        XCTAssertThrowsError(try validation.validateUsername(username)) { thrownError in
            error = thrownError as? ValidationError
        }
        
        XCTAssertEqual(expectedError, error)
    }
    
    func test_username_too_long() throws {
        let expectedError = ValidationError.usernameTooLong
        var error: ValidationError?
        let username = "very long user name1"
        
        // テスト文字列がただしいか、あらかじめチェックする
        XCTAssertTrue(username.count == 20)
        
        XCTAssertThrowsError(try validation.validateUsername(username)) { thrownError in
            error = thrownError as? ValidationError
        }
        
        XCTAssertEqual(expectedError, error)
    }
}
