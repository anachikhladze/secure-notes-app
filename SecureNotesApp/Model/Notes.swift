//
//  Notes.swift
//  SecureNotesApp
//
//  Created by Anna Sumire on 05.11.23.
//

import UIKit

struct Note {
    var title: String
    var text: String
    
    static let noteList: [Note] = [
        Note(
            title: "Kim Kardashian",
            text: "Kim Kardashian is a reality TV star and businesswoman known for her role in 'Keeping Up with the Kardashians' and her successful beauty and fashion ventures."
        ),
        Note(
            title: "Kris Jenner",
            text: "Kris Jenner is the matriarch of the Kardashian family and is often referred to as the 'momager' for managing her children's careers."
        ),
        Note(
            title: "Kylie Cosmetics",
            text: "Kylie Cosmetics is a cosmetics company founded by Kylie Jenner and is famous for its lip kits and makeup products."
        ),
        Note(
            title: "Kardashian-Jenner Apps",
            text: "The Kardashian-Jenner sisters launched individual mobile apps providing behind-the-scenes content, beauty tips, and more."
        ),
        Note(
            title: "Khloé Kardashian",
            text: "Khloé Kardashian is known for her fitness and lifestyle brand, Good American, as well as her TV appearances."
        )
    ]
}
