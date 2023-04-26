*** Settings ***
Documentation       To validate the Login form

Library             SeleniumLibrary
Library             Collections
Library             Screenshot
Library             ../customLibraries/Shop.py
Resource            ../PageObjects/LandingPage.robot


*** Variables ***
${url}=                 https://rahulshettyacademy.com/loginpagePractise/
${alert_danger}=        css:.alert-danger
${error_message}=       Incorrect username/password.
${username}=            rahulshettyacademy
${password}=            learning
${invalid_password}=    12345678
${phone_title}=         css:.card-title
${checkout_btn}=        xpath:(//a[@class='nav-link btn btn-primary'])
${product_name}=        xpath:(//h4[@class='media-heading'])
${product}=             iphone X
${nav_link}=            css:.nav-link
${confirm}=             css:.modal-body


*** Keywords ***
Wait until element passed is located on page
    [Arguments]    ${page_locator}
    Wait Until Element Is Visible    ${page_locator}

open the browser
    Open Browser    ${url}    ${browser}
#    Go To    ${url}

open the browser url
    [Arguments]    ${browser}
    Open Browser    ${url}    ${browser}
    Go To    ${url}

Ended test
    Sleep    3
    Close Browser
