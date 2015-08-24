//
//  DataStructure.swift
//  UICollectiontest
//
//  Created by MT1701 on 12/8/15.
//  Copyright (c) 2015 MT1701. All rights reserved.
//

import Foundation


class BookingObject {
    var bookingID: String!
    var bookingDate: NSDate!
    var bookingTime: NSDate!
    var status: String!
    var tableID: Int!
    var userID: String!
    var numberOfPeople: Int!
//    var guests = GuestList()
}

struct GuestList {
    var friendID: NSArray!
}