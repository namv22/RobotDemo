*** Settings ***
Documentation       To validate the Login form

Library             SeleniumLibrary
Library             Collections
Library             Screenshot
Library             String
Resource            resource.robot

Test Setup          open the browser with the Mortgage payment url
#Test Teardown    Ended


*** Test Cases ***
Validate Child window Function
    Select the link of child window
    Verify the user is switched to child window
    Grab the email id in the child window
    Switch to parent window and enter the email


*** Keywords ***
Select the link of child window
    Click Element    css:.blinkingText
    sleep    5

Verify the user is switched to child window
    Switch Window    NEW
    Element Text Should Be    css:h1    DOCUMENTS REQUEST

Grab the email id in the child window
    ${text}=    Get Text    css:.red
    @{words}=    Split String    ${text}    at
    ${text_split}=    Get From List    ${words}    1
    log    ${text_split}
    @{words_2}=    Split String    ${text_split}
    ${email}=    Get From List    ${words_2}    0
    Set Global Variable    ${email}

Switch to parent window and enter the email
    Switch Window    MAIN
    Title Should Be    LoginPage Practise | Rahul Shetty Academy
    Input Text    username    ${email}
    Input Password    password    ${password}
    Sleep    5
