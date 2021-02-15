//
//  iOS_SOAPTestTests.swift
//  iOS-SOAPTestTests
//
//  Created by maochun on 2021/2/14.
//

import XCTest
@testable import iOS_SOAPTest

class iOS_SOAPTestTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testRequest1() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        let soapMessage = "<soap:Envelope xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\"><soap:Body><getSupportCity xmlns=\"http://WebXml.com.cn/\"><byProvinceName>广东</byProvinceName></getSupportCity></soap:Body></soap:Envelope>"
        let host = "www.webxml.com.cn"
        let soapAction = "http://WebXml.com.cn/getSupportCity"
        
        let soapHdr = SoapRequestHandler()
        let (ret, str) = soapHdr.sendRequestSync(urlstr: "http://www.webxml.com.cn/WebServices/WeatherWebService.asmx", host: host, soapAction: soapAction, param: soapMessage.data(using: .utf8))
        
        print(str)
        XCTAssertEqual(ret, true, "Pass")
    }
    
    func testRequest2() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        let soapMessage = "<soap:Envelope xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\"><soap:Body><getSupportProvince xmlns=\"http://WebXml.com.cn/\" /></soap:Body></soap:Envelope>"
        let host = "www.webxml.com.cn"
        let soapAction = "http://WebXml.com.cn/getSupportProvince"
        
        let soapHdr = SoapRequestHandler()
        let (ret, str) = soapHdr.sendRequestSync(urlstr: "http://www.webxml.com.cn/WebServices/WeatherWebService.asmx", host: host, soapAction: soapAction, param: soapMessage.data(using: .utf8))
        
        print(str)
        XCTAssertEqual(ret, true, "Pass")
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
