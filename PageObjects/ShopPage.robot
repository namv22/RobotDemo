*** Settings ***
Documentation       All the page objects and keywords of landing page

Library             SeleniumLibrary
Library             Collections
Library             Screenshot
Library             ../customLibraries/Shop.py
Resource            ../PageObjects/Generic.robot
Resource            ../PageObjects/LandingPage.robot


*** Keywords ***
Verify cards title
    @{phone_list}=    Create List    iphone X    Samsung Note 8    Nokia Edge    Blackberry
    ${phone_title_lists}=    Get Webelements    ${phone_title}
    @{actual_list}=    Create List

    FOR    ${phone_title_list}    IN    @{phone_title_lists}
        Log    ${phone_title_list.text}
        Append To List    ${actual_list}    ${phone_title_list.text}
    END

    Lists Should Be Equal    ${phone_list}    ${actual_list}

Select the Card
    [Arguments]    ${cardName}
    ${phone_title_lists}=    Get Webelements    ${phone_title}
    ${index}=    Set Variable    1

    FOR    ${phone_title_list}    IN    @{phone_title_lists}
        IF    '${cardName}' == '${phone_title_list.text}'    BREAK
        ${index}=    Evaluate    ${index} + 1
    END
    Click Button    xpath:(//*[@class='card-footer'])[${index}]/button

Checkout Items
    Click Element    ${checkout_btn}

Verify Items in checkout
#    [Arguments]    ${item_name}
#    ${Result}=    Get Text    ${product_name}
#    Should Be Equal As Strings    ${Result}    ${item_name}
    Click Button    css:.btn-success
