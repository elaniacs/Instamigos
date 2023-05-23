//
//  StatusCode.swift
//  Instamigos
//
//  Created by Cáren Sousa on 23/05/23.
//

import Foundation

enum StatusCode: String {
    case success = "Request successful. The operation was completed successfully."
    case invalidData = "Invalid data. Please check the provided information and try again."
    case authenticationFailed = "Authentication failed. Please check your credentials and try again"
    case accessDenied = "Access denied. You do not have permission to access this resource."
    case resourceNotFound = "Resource not found. Please try again later."
    case requestTimeout = "The server response took too long. Please check your connection and try again."
    case internalServerError = "Internal server error. Sorry, an unexpected problem occurred. Please try again later."
    case serviceUnavailable = "The server encountered an internal error. We are working to resolve this. Please try again later."
    case unknown = "An unknown error occurred. Please try again later."
    
    static func getStatusCode(code: Int) -> StatusCode {
        switch code {
        case 200, 201: return .success
        case 400: return .invalidData
        case 401: return .authenticationFailed
        case 403: return .accessDenied
        case 404: return .resourceNotFound
        case 408: return .requestTimeout
        case 500: return .internalServerError
        case 503: return .serviceUnavailable
        default: return .unknown
        }
    }
}
