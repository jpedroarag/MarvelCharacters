//
//  ThumbnailType.swift
//  MarvelCharacters
//
//  Created by João Pedro Aragão on 18/10/20.
//

import Foundation

enum ThumbnailType: String {
    
    // Portrait aspect ratio
    
    /// 50x75px
    case portrait_small
    /// 100x150px
    case portrait_medium
    /// 150x225px
    case portrait_xlarge
    /// 168x252px
    case portrait_fantastic
    /// 216x324px
    case portrait_incredible
    /// 300x450px
    case portrait_uncanny
    
    
    
    // Square aspect ratio
    
    /// 65x45px
    case standard_small
    /// 100x100px
    case standard_medium
    /// 140x140px
    case standard_large
    /// 180x180px
    case standard_amazing
    /// 200x200px
    case standard_xlarge
    /// 250x250px
    case standard_fantastic
    
    
    
    // Landscape aspect ratio
    
    /// 120x90px
    case landscape_small
    /// 175x130px
    case landscape_medium
    /// 190x140px
    case landscape_large
    /// 270x200px
    case landscape_xlarge
    /// 250x156px
    case landscape_amazing
    /// 464x261px
    case landscape_incredible
    
    
    
    // Full-size
    
    /// 500px
    case detail
    case fullSize
    
}
