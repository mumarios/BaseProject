//
//  Users.swift
//
//  Created by Fahad Ajmal on 31/01/2018
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public final class Users: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let age = "age"
    static let username = "username"
    static let email = "email"
  }

  // MARK: Properties
  public var age: Int?
  public var username: String?
  public var email: String?

  // MARK: SwiftyJSON Initializers
  /// Initiates the instance based on the object.
  ///
  /// - parameter object: The object of either Dictionary or Array kind that was passed.
  /// - returns: An initialized instance of the class.
  public convenience init(object: Any) {
    self.init(json: JSON(object))
  }

  /// Initiates the instance based on the JSON that was passed.
  ///
  /// - parameter json: JSON object from SwiftyJSON.
  public required init(json: JSON) {
    age = json[SerializationKeys.age].int
    username = json[SerializationKeys.username].string
    email = json[SerializationKeys.email].string
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = age { dictionary[SerializationKeys.age] = value }
    if let value = username { dictionary[SerializationKeys.username] = value }
    if let value = email { dictionary[SerializationKeys.email] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.age = aDecoder.decodeObject(forKey: SerializationKeys.age) as? Int
    self.username = aDecoder.decodeObject(forKey: SerializationKeys.username) as? String
    self.email = aDecoder.decodeObject(forKey: SerializationKeys.email) as? String
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(age, forKey: SerializationKeys.age)
    aCoder.encode(username, forKey: SerializationKeys.username)
    aCoder.encode(email, forKey: SerializationKeys.email)
  }

}
