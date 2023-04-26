*** Settings ***
Documentation       All the page objects and keywords of landing page

Library             SeleniumLibrary
Library             Collections
Library             Screenshot
Library             ../customLibraries/Shop.py
Resource            ../PageObjects/Generic.robot
Resource            ../PageObjects/LandingPage.robot


*** Variables ***
${country_locator}      //a[text()='India']


*** Keywords ***
Enter the country
    [Arguments]    ${country_name}
    Input Text    country    ${country_name}
    Wait until element passed is located on page    //a[text()='${country_name}']
    Click Element    //a[text()='${country_name}']
    Sleep    2
    Click Element    checkbox2

Purchase product and confirm
    Click Button    css:.btn-success
    Page Should Contain    Success!
