//
//  Font+Custom.swift
//  TransactionManager
//
//  Created by DeveloperMB2020 on 17.06.2024.
//

import SwiftUI

extension Font {
    static var appLargeTitle: Font {
        return Font.system(size: 34, weight: .bold)
    }
    
    static var appTitle: Font {
        return Font.system(size: 28, weight: .bold)
    }

    static var appTitle2: Font {
        return Font.system(size: 17, weight: .semibold)
    }
    
    static var appTitle3: Font {
        return Font.system(size: 16, weight: .semibold)
    }

    static var appBody: Font {
        return Font.system(size: 15, weight: .semibold)
    }
    
    static var appCallout: Font {
        return Font.system(size: 15, weight: .medium)
    }
    
    static var appSubhead: Font {
        return Font.system(size: 13, weight: .semibold)
    }
    
    static var appFootnote: Font {
        return Font.system(size: 13, weight: .medium)
    }
    
    static var appCaption: Font {
        return Font.system(size: 10, weight: .regular)
    }
}
