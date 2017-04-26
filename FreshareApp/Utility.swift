import UIKit
import Foundation
import CoreLocation

class Utility {
    
    class func convertCLLocationDistanceToMiles ( targetDistance : CLLocationDistance?) -> CLLocationDistance {
        var targetDistance = targetDistance
        targetDistance =  targetDistance!*0.00062137
        return targetDistance!
    }
    class func convertCLLocationDistanceToKiloMeters ( targetDistance : CLLocationDistance?) -> CLLocationDistance {
        var targetDistance = targetDistance
        targetDistance =  targetDistance!/1000
        return targetDistance!
    }
}
