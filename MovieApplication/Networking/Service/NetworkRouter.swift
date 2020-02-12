//
//  NetworkRouter.swift
//  MovieApplication
//
//  Created by Catalina on 2/10/20.
//  Copyright © 2020 Catalina. All rights reserved.
//

import Foundation

public typealias NetworkRouterCompletion = (_ data: Data?,_ response: URLResponse?,_ error: Error?)->()

protocol NetworkRouter: class {
    associatedtype EndPoint: EndPointType
    func request(_ route: EndPoint, completion: @escaping NetworkRouterCompletion)
    func cancel()
}
