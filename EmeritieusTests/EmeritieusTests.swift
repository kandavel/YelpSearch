//
//  EmeritieusTests.swift
//  EmeritieusTests
//
//  Created by kandavel on 25/03/23.
//

import XCTest
@testable import Emeritieus

class EmeritieusTests: XCTestCase {
    
    var presenter : RestaurantListPresentor!
    var interactor : RestaurantListInterator!
    var router  : RestaurantListRouter!
    var view : MockViewListController! =  .init()
    var service : APIRouter!
    var  networkmNager : NetworkManagerProtocol!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    
    override func setUp() {
        super.setUp()
       // view = .init()
        router = .init()
        interactor = .init()
        service =  RestaurantService.search(latitude: "", longitiude: "", query: "")
        networkmNager  =  NetworkManager.shared
        presenter = .init(view: view, router: router, interactor: interactor)
    }

    override func tearDown() {
        presenter = nil
        view = nil
        router = nil
        interactor = nil
    }
    
    
    func testViewDidLoad() {
        XCTAssertFalse(view.isInvokedShowLoadingView, "Your value is true, but you expected it to be false")
        XCTAssertFalse(view.isInvokedHideLoadingView, "Your value is true, but you expected it to be false")
        XCTAssertFalse(view.isInvokedSetTitle, "Your value is true, but you expected it to be false")
        XCTAssertFalse(view.isInvokedSetupTableView, "Your value is true, but you expected it to be false")

        presenter.viewDidLoad()

        XCTAssertTrue(view.isInvokedShowLoadingView, "Your value is false, but you expected it to be true")
        XCTAssertTrue(view.isInvokedSetTitle, "Your value is false, but you expected it to be true")
        XCTAssertTrue(view.isInvokedSetupTableView, "Your value is false, but you expected it to be true")
    }
    
    func testViewModelIntialValues() {
        XCTAssertNil(presenter.didFetchItemAtIdex(indexPath: IndexPath(item: 0, section: 0)), "Nil" )
        XCTAssertEqual(presenter.isFiltering, false)
        XCTAssertEqual(presenter.numberOfItems(), 0)
        
        
    }
    
    func testNetworkServiceLayer(){
        service  = RestaurantService.search(latitude: "37.786882", longitiude: "-122.399972", query: "Mourad Restaurant")
        /*let queryitem  =  URLQueryItem(name: "term", value: "restaurants"),
            URLQueryItem(name: "latitude", value: latitude),
            URLQueryItem(name: "longitude", value: longitiude),
            URLQueryItem(name: "query", value: query)*/
        let firstValue = service.queryItems?.filter {$0.name  ==  "latitude"}.first?.value ?? ""
        let secondValue = service.queryItems?.filter {$0.name  ==  "longitude"}.first?.value ?? ""
        XCTAssertEqual(service.httpMethod, .get)
        XCTAssertEqual(service.host, "api.yelp.com")
        XCTAssertEqual(firstValue, "37.786882")
        XCTAssertEqual(secondValue, "-122.399972")
        XCTAssertEqual(service.request?.url?.absoluteString, "https://api.yelp.com/v3/businesses/search?term=restaurants&latitude=37.786882&longitude=-122.399972&query=Mourad%20Restaurant")
        
    }
    
    func testViewModelDataFunctionality() {
        presenter.fetchRestaurantListOutput(result: ResultCallback.success(RestaurantListResult.response))
        XCTAssertTrue(presenter.numberOfItems() >  0)
        presenter.setSearchTextState()
        presenter.searchTextChanged("Lao")
        //Search Data Count
        print("After Search :: \(presenter.numberOfItems())")
        XCTAssertTrue(presenter.numberOfItems() >=  1)
        XCTAssertTrue((presenter.didFetchItemAtIdex(indexPath: IndexPath(item: 0, section: 0)) != nil))
        
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

typealias RestaurantListResult  =  Result<BusinessInfo,NetworkError>
typealias RestaurantDetailResult  = Result<RestaurantDetail,NetworkError>

extension RestaurantListResult {
    static var response: BusinessInfo {
        let bundle = Bundle(for: EmeritieusTests.self)
        let path = bundle.path(forResource: "RestaurantList", ofType: "json")!
        let file = try! String(contentsOfFile: path)
        let data = file.data(using: .utf8)!
        let movieResponse = try! JSONDecoder().decode(BusinessInfo.self, from: data)
        return movieResponse
    }
}

extension RestaurantDetailResult {
    static var response: RestaurantDetail {
        let bundle = Bundle(for: EmeritieusTests.self)
        let path = bundle.path(forResource: "RestaurantDetail", ofType: "json")!
        let file = try! String(contentsOfFile: path)
        let data = file.data(using: .utf8)!
        let movieResponse = try! JSONDecoder().decode(RestaurantDetail.self, from: data)
        return movieResponse
    }
}
