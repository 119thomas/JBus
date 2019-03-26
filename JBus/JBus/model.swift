//
//  model.swift
//  JBus
//
//  Created by William Thomas on 3/15/19.
//  Copyright © 2019 William Thomas. All rights reserved.
//

import Foundation
import UIKit

struct stop: Hashable {
    var tag: String
    var title: String
    var stopId: String
}

struct shuttle: Hashable {
    var title: String
    var color: UIColor
    var oppositeColor: UIColor
    var routeTag: String
    var stops: [stop]
}

class brains: NSObject, XMLParserDelegate {
    private var configParser: XMLParser?, tagParser: XMLParser?, predictionParser: XMLParser?
    private var shuttles = [shuttle]()
    private var routeStops = [stop]()
    private var arrivals = [(String, Int)]()
    private var routeTags = [String]()
    private var agencyTag: String?, routeTitle: String?, routeColor: String?,
                routeOppositeColor: String?, routeTag: String?, stopTag: String?,
                stopTitle: String?, stopId: String?, arrivalTime: String?
    
    /* On initialization we will create an array of shuttles. This will consist of
    first setting our agency tag (This means our NextBus data will be specifically
    retrieved for The University of Maryland shuttle system). Next we need to
    retrieve the route tags for each bus currently operating. Once we do this, we
    can generate a new shuttle object for each tag, giving each one its proper attributes */
    override init() {
        super.init()
        agencyTag = "umd"
    }
    
    func execute() {
        setRouteTags()
        configRoutes()
    }
    
    func printShuttle(shuttle: shuttle) {
        print("title: \(shuttle.title)\ncolor: \(shuttle.color)\nopposite color: \(shuttle.oppositeColor)\nroute tag: \(shuttle.routeTag)")
        print("~~~~stops~~~~:")
        for stop in shuttle.stops {
            print("title: \(stop.title), tag: \(stop.tag), stopId: \(stop.stopId)")
            
            let predictions = requestPredictions(stop: stop)
            print("prediction count: \(predictions.count)")
//            for prediction in predictions {
//                print(prediction)
//            }
        }
        print("")
    }
    
    /* Returns a list of every shuttle currently running at UMD */
    func getShuttles() -> [shuttle] {
        return shuttles
    }
    
    /* Returns a list of stops for the given UMD shuttle */
    func getStops(shuttle: shuttle) -> [stop] {
        return shuttle.stops
    }
    
    /* Create a list of all the availible 'route tags'. Before we can get any information
     about a shuttle (i.e. departure, arrival etc.), we need its 'route tag'. A route tag
     is a unique alphanumeric identifier for a route, such as "N". We will append this
     route tag to future URLs.*/
    private func setRouteTags() {
        tagParser = XMLParser(contentsOf: URL(string:"http://webservices.nextbus.com/service/publicXMLFeed?command=routeList&a=\(agencyTag!)")!)!
        tagParser!.delegate = self
        tagParser!.parse()
    }
    
    /* Parses the XML for each routeTag in our list. */
    private func configRoutes() {
        for routeTag in routeTags {
            configParser = XMLParser(contentsOf: URL(string:"http://webservices.nextbus.com/service/publicXMLFeed?command=routeConfig&a=\(agencyTag!)&r=\(routeTag)")!)!
            configParser!.delegate = self
            configParser!.parse()
        }
    }
    
    /* Returns a list of strings that represent the amount of time until the
     next shuttle arrives at the provided stop */
    func requestPredictions(stop: stop) -> [(String, Int)] {
        arrivals.removeAll()
        predictionParser = XMLParser(contentsOf: URL(string:"http://webservices.nextbus.com/service/publicXMLFeed?command=predictions&a=\(agencyTag!)&stopId=\(stop.stopId)")!)!
        predictionParser!.delegate = self
        self.predictionParser!.parse()
        
        // does prediction parser.parse ALWAYS finish before we return arrivals??
        // we should sort arrivals before we return it
        return arrivals
    }
    
    /* Delegate function(s); DO NOT MAKE PRIVATE */
    
    /* Parses the XML document looking for the key didStartElements: tag, route, stop, minutes=
    These keywords represent the 'key' in our attributes dictionary that will be used to extract
    a 'value', which represents important data in the XML (i.e. the name of a shuttle or the
    time until it's arrival at a particualar stop) */
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
        for attribute in attributeDict {
            switch parser {
                case tagParser:
                    if(attribute.key == "tag") {
                        routeTags.append(attribute.value)
                    }
                case configParser:
                    if(elementName == "route") {
                        switch attribute.key {
                            case "tag": routeTag = attribute.value
                            case "title": routeTitle = attribute.value
                            case "color": routeColor = attribute.value
                            case "oppositeColor": routeOppositeColor = attribute.value
                            default: break
                        }
                    }
                    else if(elementName == "stop") {
                        switch attribute.key {
                        case "tag": stopTag = attribute.value
                            case "title": stopTitle = attribute.value
                            case "stopId": stopId = attribute.value
                            default: break
                        }
                    }
                case predictionParser:
                    switch elementName {
                        case "predictions":
                            if(attribute.key == "routeTitle") {
                                routeTitle = attribute.value
                            }
                        case "prediction":
                            
                            if(attribute.key == "minutes") {
                                arrivalTime = attribute.value
                            }
                        default: break
                    }
                default: break
            }
        }
    }
    
    /* After a parser reaches the end of a stop element in the XML, it will call
     this function where we will create a new stop object to represent the data.
     After we create the new stop, we will reset the data to nil; this will prevent
     the parser from reading incorect stop elements in the XML */
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if(parser == configParser && elementName == "stop") {
            if(stopTag != nil && stopTitle != nil && stopId != nil) {
                let newStop = stop(tag: stopTag!, title: stopTitle!, stopId: stopId!)
                routeStops.append(newStop)
                stopTag = nil; stopTitle = nil; stopId = nil
            }
        }
        if(parser == predictionParser && elementName == "prediction") {
            if(arrivalTime != nil) {
                arrivals.append((routeTitle!, Int(arrivalTime!)!))
                arrivalTime = nil
            }
        }
    }
    
    /* This function will be called after a configParser finishes reading a specific
    shuttle's XML file. Once the file has been read and the data extracted, we will create
    a new shuttle object to represent that data. */
    func parserDidEndDocument(_ parser: XMLParser) {
        if(parser == configParser) {
            let color = UIColor(hexString: "#\(routeColor ?? "fffff")ff")
            let oppositeColor = UIColor(hexString: "#\(routeOppositeColor ?? "fffff")ff")
            let newShuttle = shuttle(title: routeTitle ?? "", color: color!, oppositeColor: oppositeColor!, routeTag: routeTag ?? "", stops: routeStops)
            shuttles.append(newShuttle)
            routeStops.removeAll()
        }
    }
    
    /* Failed to parse XML */
    func parser(_ parser: XMLParser, parseErrorOccurred parseError: Error) {
        NSLog("failure error: \(parseError)")
    }
}

/* UIColor Extension */

/* Converts hex value to UIColor
    Extension from:
    https://www.hackingwithswift.com/example-code/uicolor/how-to-convert-a-hex-color-to-a-uicolor
    props to: Paul Hudson, https://www.hackingwithswift.com/about */
extension UIColor {
    public convenience init?(hexString: String) {
        let r, g, b, a: CGFloat
        
        if hexString.hasPrefix("#") {
            let start = hexString.index(hexString.startIndex, offsetBy: 1)
            let hexColor = String(hexString[start...])
            
            if hexColor.count == 8 {
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0
                
                if scanner.scanHexInt64(&hexNumber) {
                    r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
                    g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
                    b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
                    a = CGFloat(hexNumber & 0x000000ff) / 255
                    
                    self.init(red: r, green: g, blue: b, alpha: a)
                    return
                }
            }
        }
        return nil
    }
}
