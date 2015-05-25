//
//  Sweather_Underground.swift
// was functions from open weather api, i converted them to weather underground.
// old "http://api.openweathermap.org/data/"

import Foundation
import CoreLocation

public class Sweather_Underground {
    public enum TemperatureFormat: String {
        case Celsius = "metric"
        case Fahrenheit = "imperial"
    }
    
    public enum Result {
        case Success(NSURLResponse!, NSDictionary!)
        case Error(NSURLResponse!, NSError!)
        
        public func data() -> NSDictionary? {
            switch self {
            case .Success(let response, let dictionary):
                return dictionary
            case .Error(let response, let error):
                return nil
            }
        }
        
        public func response() -> NSURLResponse? {
            switch self {
            case .Success(let response, let dictionary):
                return response
            case .Error(let response, let error):
                return response
            }
        }
        
        public func error() -> NSError? {
            switch self {
            case .Success(let response, let dictionary):
                return nil
            case .Error(let response, let error):
                return error
            }
        }
    }
    
    public var apiKey: String
    //public var apiVersion: String
    //public var language: String
    //public var temperatureFormat: TemperatureFormat
    
    private var queue: NSOperationQueue;
    
    private struct Const {
       let basePath = "http://api.openweathermap.org/data/2.5/forecast"
    }
  
  
  
    // MARK: -
    // MARK: Initialization
  
   /*public convenience init(apiKey: String) {
        self.apiKey = apiKey
        self.init(apiKey: apiKey)
    }
  
     public convenience init(apiKey: String, temperatureFormat: TemperatureFormat) {
        self.init(apiKey: apiKey, language: "en", temperatureFormat: temperatureFormat, apiVersion: "2.5")
    }
    
    public convenience init(apiKey: String, language: String, temperatureFormat: TemperatureFormat) {
        self.init(apiKey: apiKey, language: language, temperatureFormat: temperatureFormat, apiVersion: "2.5")
    }*/
    
    public init(apiKey: String) {
    //public init(apiKey: String, language: String, temperatureFormat: TemperatureFormat, apiVersion: String) {
        self.apiKey = apiKey
        //self.temperatureFormat = temperatureFormat
        //self.apiVersion = apiVersion
        //self.language = language
        self.queue = NSOperationQueue()
    }
    
    // MARK: -
    // MARK: Retrieving data
    
    public func currentWeather(cityName: String, callback: (Result) -> ()) {
        // old call("/weather?q=\(cityName)", callback: callback);
    }

    public func findCity(coordinate: CLLocationCoordinate2D, callback: (Result) -> ()) {
    call("http://api.wunderground.com/api/75d83e44364c755f/geolookup/q/\(coordinate.latitude),\(coordinate.longitude).json", callback: callback);
    }
  
    public func forecast(cityName: String, state: String, dateVal: String, callback: (Result) -> ()) {
        call("http://api.wunderground.com/api/75d83e44364c755f/history_\(dateVal)/q/\(state)/\(cityName).json", callback: callback);
    }
    
    // MARK: -
    // MARK: Call the api
    
    private func call(url: String, callback: (Result) -> ()) {
        println(url)
        let request = NSURLRequest(URL: NSURL(string: url)!)
        let currentQueue = NSOperationQueue.currentQueue();
        
        NSURLConnection.sendAsynchronousRequest(request, queue: queue) { (response: NSURLResponse!, data: NSData!, error: NSError?) -> Void in
            var error: NSError? = error
            var dictionary: NSDictionary?
            
            if let data = data {
               dictionary = NSJSONSerialization.JSONObjectWithData(data, options: .MutableContainers, error: &error) as? NSDictionary;
            }
            currentQueue?.addOperationWithBlock {
                var result = Result.Success(response, dictionary)
                if error != nil {
                    result = Result.Error(response, error)
                }
                callback(result)
            }
        }
    }
  
}