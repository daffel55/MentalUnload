//
//  FirstTipChecklist.swift
//  MentalUnload
//
//  Created by Dagmar Feldt on 28.07.24.
//



import Foundation
import TipKit

struct FirstTipCheckList: Tip {
    var title: Text {
        Text("Demo")
    }
    var message: Text? {
        Text(NSLocalizedString("firstTipMessage", comment: ""))
    }
}

struct FolderTip: Tip {
    var title: Text {
        Text(NSLocalizedString("CampingFolder", comment: ""))
    }
    var message: Text? {
        Text(NSLocalizedString("CampingFolderInfo", comment: ""))
    }
}

