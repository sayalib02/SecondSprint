//
//  UnitTestingClass.swift
//  SecondSprintTests
//
//  Created by Capgemini-DA071 on 9/27/22.
//

import XCTest
@testable import SecondSprint

class UnitTestingClass: XCTestCase {
    
    var loginVc: LoginViewController!
    var signUpVc: SignUpViewController!
    var cartVc: CartViewController!
    var mapVc: MapViewController!
    var localVc: LocalNotificationViewController!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        signUpVc = SignUpViewController.getVC()
        signUpVc.loadViewIfNeeded()
        
        loginVc = LoginViewController.getVC()
        loginVc.loadViewIfNeeded()
        
        cartVc = CartViewController.getVC()
        cartVc.loadViewIfNeeded()
        
        mapVc = MapViewController.getVC()
        mapVc.loadViewIfNeeded()
        
        localVc = LocalNotificationViewController.getVC()
        localVc.loadViewIfNeeded()
        
        
        
    }

    func test_checkButtonAction() throws{
        //Sign Up
        let signUpBtn : UIButton = try XCTUnwrap(signUpVc.signUpButton,"sign up not have referencing outlet")
        let signAct = try XCTUnwrap(signUpBtn.actions(forTarget: signUpVc, forControlEvent: .touchUpInside),"No action")
        XCTAssertEqual(signAct.count,1)
        
        //Login
        let loginBtn : UIButton = try XCTUnwrap(loginVc.loginButton,"Login not have referencing outlet")
        let loginAct = try XCTUnwrap(loginBtn.actions(forTarget: loginVc, forControlEvent: .touchUpInside),"No action")
        XCTAssertEqual(loginAct.count,1)
        
        //Cart
        let cartBtn : UIButton = try XCTUnwrap(cartVc.placeOrder,"Cart not have referencing outlet")
        guard let cartAct = cartBtn.actions(forTarget: cartVc, forControlEvent:.touchUpInside) else{
            XCTFail("No action")
            return
        }
        
        let localBtn: UIButton = try XCTUnwrap(localVc.localNotificationButton,"Local Notification not having referencing outlet")
        let localAct = try XCTUnwrap(localBtn.actions(forTarget:localVc, forControlEvent:.touchUpInside),"No action")
        XCTAssertEqual(localAct.count,1)
        
        
        
        let mapBtn: UIButton = try XCTUnwrap(mapVc.orderNowButton,"Map not having referencing outlet")
        let mapAct = try XCTUnwrap(mapBtn.actions(forTarget:mapVc, forControlEvent:.touchUpInside),"No action")
        XCTAssertEqual(mapAct.count,1)
    }
    
    
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
