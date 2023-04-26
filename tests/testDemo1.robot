*** Settings ***
Documentation       To validate the Login form

Library             SeleniumLibrary

Test Teardown       Ended
#Resource


*** Variables ***
${chromedriver_path}=       chromedriversync.Get Chromedriver Path
${url}=                     https://rahulshettyacademy.com/loginpagePractise/
${alert_danger}=            css:.alert-danger
${error_message}=           Incorrect username/password.


*** Test Cases ***
Validate UnSuccesful Login
    open the browser with the Mortgage payment url
    Fill the login Form
    wait until it checks and display error message
    verify error message is correct


*** Keywords ***
open the browser with the Mortgage payment url
    Create Webdriver    Chrome    executable_path=${chromedriver_path}
    Go To    ${url}

Fill the login Form
    Input Text    id:username    rahulshettyacademy
    Input Password    id:password    12345678
    Click Button    signInBtn

wait until it checks and display error message
    Wait Until Element Is Visible    ${alert_danger}

verify error message is correct
    ${Result}=    Get Text    ${alert_danger}
    Should Be Equal As Strings    ${Result}    Incorrect username/password.
    Element Text Should Be    ${error_message}    Incorrect username/password.

Ended
    Close Browser
