//
//  DeviceType.swift
//  EasyVideoEditor
//
//  Created by Shachar Udi on 07/07/2021.
//

import UIKit

class UserDeviceType {
    
    class func isIPad() -> Bool {
        return UIDevice.current.userInterfaceIdiom == .pad
    }
    
    class func isSmallDevice() -> Bool {
        return UIScreen.main.bounds.height <= 667.0
    }
}
