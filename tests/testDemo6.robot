*** Settings ***
Documentation       To validate the Login form

Library             SeleniumLibrary
Library             Collections
Library             Screenshot
Library             ../customLibraries/Shop.py
Resource            ../PageObjects/Generic.robot
Resource            ../PageObjects/LandingPage.robot
Resource            ../PageObjects/ShopPage.robot
Resource            ../PageObjects/Confirm.robot

Test Setup          Open The Browser Url    ${browser_name}
Test Teardown       Ended test


*** Variables ***
@{listofProducts}       Blackberry    Nokia Edge
${country_name}         India
${browser_name}         chrome


*** Test Cases ***
Validate UnSuccesful Login
    [Tags]    error
    Fill the login Form    ${username}    ${invalid_password}
    Wait for element visible    ${alert_danger}
    Verify error message is correct

Validate Cards display in the Shopping page
    [Tags]    nr
    LandingPage.Fill The Login Form    ${username}    ${password}
    LandingPage.Wait for element visible    ${nav_link}
    ShopPage.Verify Cards Title
#    Hello World
    Add Items To Cart And Checkout    ${listofProducts}
#    Select the Card    ${product}
    ShopPage.Checkout Items
    ShopPage.Verify Items In Checkout
    Confirm.Enter the country    ${country_name}
    Confirm.Purchase Product And Confirm

Select the form and navigate to child window
    Fill the login and select User option
