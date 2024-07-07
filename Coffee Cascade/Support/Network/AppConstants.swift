//
//  AppConstants.swift
//  Coffee Cascade
//
//  Created by Николай Лермонтов on 07.07.2024.
//

import Foundation

public final class AppConstants {
    // MARK: - Public Type Properties

    public static let baseURL = "https://starbucks-coffee-db2.p.rapidapi.com/api/"
    public static let host = "starbucks-coffee-db2.p.rapidapi.com"
    public static let apiKey: String? = environment?["STARBUCKS_API_KEY"] as? String

    // MARK: - Private Type Properties

    private static let environment: [String: Any]? = {
        guard
            let environmentPropertyListURL = Bundle(for: AppConstants.self).url(
                forResource: "Environment",
                withExtension: "plist"
            ),
            let environmentDictionary = NSDictionary(contentsOf: environmentPropertyListURL)
        else { return nil }

        return environmentDictionary as? [String: Any]
    }()
}
