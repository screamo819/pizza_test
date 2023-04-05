//
//  NetworkError.swift
//  PIZZA_TEST
//
//  Created by Evgeny on 05.04.2023.
//

import Foundation

extension Swift.Error {
  var isNetworkConnectionError: Bool {
    (self as? NetworkSessionError)?.isNetworkConnectionError == true ||
    ((self as NSError).isNotConnectedToInternet ||
      (self as NSError).isNetworkConnectionLost) ||
      (self as NSError).isNetworkTimeout ||
      (self as NSError).isNetworkCannotConnectToHost
    }
}

extension NSError {
  var isNetworkConnectionLost: Bool {
    (domain == NSURLErrorDomain && code == NSURLErrorNetworkConnectionLost)
  }
  var isNetworkCannotConnectToHost: Bool {
    (domain == NSURLErrorDomain && code == NSURLErrorCannotConnectToHost)
  }
  var isNotConnectedToInternet: Bool {
    (domain == NSURLErrorDomain && code == NSURLErrorNotConnectedToInternet)
  }
  var isNetworkTimeout: Bool {
    (domain == NSURLErrorDomain && code == NSURLErrorTimedOut)
  }
}
