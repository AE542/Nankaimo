//
//  TestHelpers.swift
//  ProtoKanjiAppV.3Tests
//
//  Created by Mohammed Qureshi on 2021/10/18.
//

//create a test helper file to handle the button presses. Call the button press method in the test file you're using. The whole point of Test Helpers is to increase readability and increase test durability.

import UIKit

//UIButton Test helper:

func tapButton(_ button: UIButton) {
    button.sendActions(for: .touchUpInside) //always use touchUpInside for button testing.
}

//UIBarButton Test helper:

func tapBarButton(_ button: UIBarButtonItem) {
    _ = button.target?.perform(button.action, with: nil)
    //how to call the button when it's programmattic?
}
