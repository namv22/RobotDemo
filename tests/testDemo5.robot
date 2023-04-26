*** Settings ***
Documentation       To validate the Login form

Library             SeleniumLibrary
Library             DataDriver    file=resources/data.csv    encoding=utf_8    dialect=unix

Test Teardown       Ended
Test Template       Validate UnSuccesful Login


*** Variables ***
${chromedriver_path}=       chromedriversync.Get Chromedriver Path
${url}=                     https://rahulshettyacademy.com/loginpagePractise/
${alert_danger}=            css:.alert-danger
${error_message}=           Incorrect username/password.


*** Test Cases ***
Login with user ${username} and password ${password}    xyz    123456


*** Keywords ***
Validate UnSuccesful Login
    [Arguments]    ${username}    ${password}
    open the browser with the Mortgage payment url
    Fill the login Form    ${username}    ${password}
    wait until it checks and display error message
    verify error message is correct

open the browser with the Mortgage payment url
    Create Webdriver    Chrome    executable_path=${chromedriver_path}
    Go To    ${url}

Fill the login Form
    [Arguments]    ${username}    ${password}
    Input Text    id:username    ${username}
    Input Password    id:password    ${password}
    Click Button    signInBtn

wait until it checks and display error message
    Wait Until Element Is Visible    ${alert_danger}

verify error message is correct
    ${Result}=    Get Text    ${alert_danger}
    Should Be Equal As Strings    ${Result}    Incorrect username/password.
#    Element Text Should Be    ${error_message}    Incorrect username/password.

Ended
    Sleep    5
    Close Browser
