//
//  APIConfiguration.swift
//  Souq
//
//  Created by Ahmed Elbasha on 8/13/18.
//  Copyright © 2018 Ahmed Elbasha. All rights reserved.
//

import Foundation

// To pass the categoryId value to generateApiUrl() method.
var categoryId: Int32 = 0

// To pass the countryId value to generateApiUrl() method.
var countryId: Int32 = 0

// To generate the valid web API Url.
func generateApiUrl(usingCategoryId categoryId: Int32, andCountryID countryId: Int32) -> String {
    return "http://souq.hardtask.co/app/app.asmx/GetCategories?categoryId=\(categoryId)&countryId=\(countryId)"
}
