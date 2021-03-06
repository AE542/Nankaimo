//
//  TestHelpers.swift
//  ProtoKanjiAppV.3Tests
//
//  Created by Mohammed Qureshi on 2021/10/18.
//

//create a test helper file to handle the button presses. Call the button press method in the test file you're using. The whole point of Test Helpers is to increase readability and increase test durability.

import UIKit

//MARK: - UIButton and UIBarButton Helpers

func tapButton(_ button: UIButton) {
    button.sendActions(for: .touchUpInside) //always use touchUpInside for button testing.
}

func tapBarButton(_ button: UIBarButtonItem) {
    _ = button.target?.perform(button.action, with: nil)
    //how to call the button when it's programmattic?
}

//OK so testing segues we need to make sure they have their run loop executed to avoid the tests crashing immediately without checking their assertions.

func executeRunLoop() {
    RunLoop.current.run(until: Date())
}

//MARK: - View Hierarchy Test Helpers
//put in window to get the segues to work

func putInWindow(_ vc: UIViewController) {
    let window = UIWindow()
    window.rootViewController = vc
    window.isHidden = false
}

//make sure the view is loaded in the vc

func putInViewHierarchy(_ vc: UIViewController) {
    let window = UIWindow()
    window.addSubview(vc.view)
}

//We can create a helper to make sure that the focus is resigned from each textfield when the return button is pressed

//MARK: - UITextFieldHelpers

@discardableResult func shouldReturn(in textfield: UITextField) -> Bool? {
    textfield.delegate?.textFieldShouldReturn?(textfield)
}
//remember @discardableResult is used so we can ignore the delegate's return value for the purposes of testing.

func shouldDismiss(in textfield: UITextField) {
    //textfield.delegate?.textFieldShouldEndEditing?(textfield)
    //textfield.delegate?.textFieldShouldReturn?(textfield)
    textfield.resignFirstResponder()
}

//MARK: - TableView Test Helpers
//testing tableview rows helper. Shortens the code we call in the test case

func numberOfRows(in tableView: UITableView, section: Int = 0) -> Int? {
    tableView.dataSource?.tableView(tableView, numberOfRowsInSection: section)
}

func cellForRowAt(in tableView: UITableView, row: Int, section: Int = 0) -> UITableViewCell? { //must return an OPTIONAL UITableViewCell! There might not be one!
    tableView.dataSource?.tableView(tableView, cellForRowAt: IndexPath(row: 0, section: section))
}

func didSelectRow(in tableView: UITableView, row: Int, section: Int = 0) {
    //Int is set to zero as in most cases, tableViews' sections are set to 0 in most apps.
    tableView.delegate?.tableView?(tableView, didSelectRowAt: IndexPath(row: row, section: section))
}

func shouldChangeCharacters(in textField: UITextField, range: NSRange = NSRange(), replacement: String) -> Bool? {
    textField.delegate?.textField?(textField, shouldChangeCharactersIn: range, replacementString: replacement)
} //we can test if the textfields are allowing spaces or not when text is entered. For the sake of readability.


extension UITextContentType: CustomStringConvertible {
    public var description: String {
        rawValue
    }
    
    //we can extend UITextContentType to conform to the custom string convertible protocol. With this we can create custom error messages to provide better assertions when a test fails.
}

extension UITextAutocapitalizationType: CustomStringConvertible {
    public var description: String {
        switch self {
        case .none:
            return "default"
        case .words:
            return "words"
        case .sentences:
            return "sentences"
        case .allCharacters:
            return "allCharacters"
        @unknown default:
            fatalError("Unknown UITextAutocapitalizationType")
        }
    }
    //far clearer when a different attribute is set to one that is expected.
    
}
