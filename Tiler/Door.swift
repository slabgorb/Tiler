//
//  Door.swift
//  Tiler
//
//  Created by Keith Avery on 3/11/16.
//  Copyright © 2016 Keith Avery. All rights reserved.
//

import Foundation
class Door:NSObject, NSCoding {
    // MARK:- Mechanism
    enum Mechanism:String {
        case OpensIn = "Opens In"
        case OpensOut = "Opens Out"
        case SlidesHorizontal = "Slides Horizontally"
        case Secret = "Secret"
    }
    
    // MARK:- OpenState
    enum OpenState: String {
        case Open = "Open"
        case Closed = "Closed"
    }
    
    // MARK:- LockState
    enum LockState: String {
        case Locked = "Locked"
        case Unlocked = "Unlocked"
    }
    
    // MARK:- Properties
    var mechanism: Mechanism = .OpensIn
    var isOpen: OpenState = .Open
    var isLocked: LockState = .Unlocked
    
    // MARK:- Initialization
    override init () { }
    
    
    convenience init (mechanism: Mechanism) {
        self.init()
        self.mechanism = mechanism
    }
    convenience init (mechanism: Mechanism, open: OpenState) {
        self.init(mechanism: mechanism)
        self.isOpen = open
    }
    
    convenience init (mechanism: Mechanism, open: OpenState, locked: LockState) {
        self.init(mechanism: mechanism, open: open)
        self.isLocked = locked
    }
    
    // MARK:- Serialization
    required init?(coder aDecoder: NSCoder) {
        
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(self.mechanism.rawValue, forKey: "size")
        aCoder.encodeObject(self.isOpen.rawValue, forKey: "isOpen")
        aCoder.encodeObject(self.isLocked.rawValue, forKey: "isLocked")
    }
    
    // MARK:- Methods
    func open(state: OpenState = .Open) {
        self.isOpen = state
    }
    
    func close(state: OpenState = .Closed) {
        self.isOpen = state
    }
    
    func lock(state: LockState = .Locked) {
        self.isLocked = state
    }
    
    func unlock(state: LockState = .Locked) {
        self.isLocked = state
    }
    
}