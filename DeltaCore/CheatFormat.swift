//
//  CheatFormat.swift
//  DeltaCore
//
//  Created by Riley Testut on 5/22/16.
//  Copyright © 2016 Riley Testut. All rights reserved.
//

import Foundation

public struct CheatFormat
{
    public let name: String

    // Must begin and end with an alphanumberic character. Besides these, non-alphanumberic characters will be treated as special formatting characters.
    // Ex: XXXX-YYYY. The "-" is a special formatting character, and should be automatically inserted between alphanumeric characters by a code editor
    public let format: String
    
    public let type: CheatType
    
    public let allowedCodeCharacters: CharacterSet
    
    public init(name: String, format: String, type: CheatType, allowedCodeCharacters: CharacterSet = CharacterSet.hexadecimalCharacterSet())
    {
        self.name = name
        self.format = format
        self.type = type
        self.allowedCodeCharacters = allowedCodeCharacters
    }
}

public extension CharacterSet
{
    static func hexadecimalCharacterSet() -> CharacterSet
    {
        let characterSet = CharacterSet(charactersIn: "0123456789ABCDEFabcdef")
        return characterSet
    }
}

public extension String
{
    func sanitized(characterSet: CharacterSet) -> String
    {
        let sanitizedString = (self as NSString).components(separatedBy: characterSet.inverted).joined(separator: "")
        return sanitizedString
    }
    
    func formatted(cheatFormat: CheatFormat) -> String
    {
        // NOTE: We do not use cheatFormat.allowedCodeCharacters because the code format typically includes non-legal characters.
        // Ex: Using "XXXX-YYYY" for the code format despite the actual code format being strictly hexadecial characters.
        // This is okay because this function's job is not to validate the input, but simply to format it
        let characterSet = CharacterSet.alphanumerics
        
        // Remove all characters not in characterSet
        let sanitizedFormat = cheatFormat.format.sanitized(characterSet: characterSet)
        
        // We need to repeat the format enough times so it is greater than or equal to the length of self
        // This prevents us from having to account for wrapping around the cheat format
        let repetitions = Int(ceil((Float(self.characters.count) / Float(sanitizedFormat.characters.count))))
        
        var format = ""
        for i in 0 ..< repetitions
        {
            if i > 0
            {
                format += "\n"
            }
            
            format += cheatFormat.format
        }
        
        
        var formattedString = ""
        
        // Serves as a sort of stack buffer for us to draw characters from
        let codeBuffer = NSMutableString(string: self)
        
        let scanner = Scanner(string: format)
        scanner.charactersToBeSkipped = nil
        
        while !scanner.isAtEnd
        {
            // Scan up until the first separator character
            var string: NSString? = nil
            scanner.scanCharacters(from: characterSet, into: &string)
            
            // Might start with separator characters, in which case scannedString would be nil/empty
            if let scannedString = string where scannedString.length > 0
            {
                let range = NSRange(location: 0, length: min(scannedString.length, codeBuffer.length))
                
                // "Pop off" characters from the front of codeBuffer
                let code = codeBuffer.substring(with: range)
                codeBuffer.replaceCharacters(in: range, with: "")
                
                formattedString += code
                
                // No characters left in buffer means we've finished formatting
                guard codeBuffer.length > 0 else { break }
            }
            
            // Scan all separator characters
            var separatorString: NSString? = nil
            scanner.scanUpToCharacters(from: characterSet, into: &separatorString)
            
            // If no separator characters, we're done!
            guard let tempString = separatorString as? String where separatorString?.length > 0 else { break }
            
            formattedString += tempString
        }
        
        // Ensure it is all uppercase
        return formattedString.uppercased()
    }
}