//
//  Video.swift
//  MenuBarYoutube
//
//  Created by xszhao on 2017-04-02.
//  Copyright © 2017 xszhao. All rights reserved.
//

import UIKit

class Video: NSObject {
    
    var thumbnailImageName: String?
    var title: String?
    var numberOfViews: NSNumber?
    var uploadDate: Date?
    
    var channel: Channel?
    
}

class Channel: NSObject {
    var name: String?
    var profileImageName: String?
}
