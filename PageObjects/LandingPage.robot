*** Settings ***
Documentation       All the page objects and keywords of landing page

Library             SeleniumLibrary
Library             Collections
Library             Screenshot
Library             ../customLibraries/Shop.py
Resource            ../PageObjects/Generic.robot
Resource            ../PageObjects/ShopPage.robot


*** Keywords ***
Fill the login Form
    [Arguments]    ${username}    ${password}
    Input Text    id:username    ${username}
    Input Password    id:password    ${password}
    Click Button    signInBtn

Wait for element visible
    [Arguments]    ${elements}
    Wait Until Element Is Visible    ${elements}

Verify error message is correct
    ${Result}=    Get Text    ${alert_danger}
    Should Be Equal As Strings    ${Result}    Incorrect username/password.
#    Element Text Should Be    ${error_message}    Incorrect username/password.

Fill the login and select User option
    Input Text    id:username    ${username}
    Input Password    id:password    ${password}
    Click Element    css:input[value='user']
    Wait For Element Visible    ${confirm}
    Click Button    okayBtn
    Click Button    okayBtn
    Wait Until Element Is Not Visible    css:.modal-body
    Select From List By Value    css:select.form-control    teach
    Select Checkbox    terms
    Checkbox Should Be Selected    terms
    Take Screenshot
