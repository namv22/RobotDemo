*** Settings ***
Documentation       To validate the Login form

Library             SeleniumLibrary
Library             Collections
Library             Screenshot
Resource            resource.robot

Test Setup          open the browser with the Mortgage payment url
#Test Teardown    Ended test


*** Test Cases ***
#Validate UnSuccesful Login
#    Fill the login Form    ${username}    ${invalid_password}
#    Wait for element visible    ${alert_danger}
#    Verify error message is correct

Validate Cards display in the Shopping page
    Fill The Login Form    ${username}    ${password}
    Wait for element visible    ${nav_link}
    Verify Cards Title
    Select the Card    ${product}
    Checkout Items
    Verify Items In Checkout    ${product}

#Select the form and navigate to child window
#    Fill the login and select User option


*** Keywords ***
Fill the login Form
    [Arguments]    ${username}    ${password}
    Input Text    id:username    ${username}
    Input Password    id:password    ${password}
    Click Button    signInBtn

Wait for element visible
    [Arguments]    ${element}
    Wait Until Element Is Visible    ${element}

Verify error message is correct
    ${Result}=    Get Text    ${alert_danger}
    Should Be Equal As Strings    ${Result}    Incorrect username/password.
#    Element Text Should Be    ${error_message}    Incorrect username/password.

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
    [Arguments]    ${item_name}
    ${Result}=    Get Text    ${product_name}
    Should Be Equal As Strings    ${Result}    ${item_name}

Fill the login and select User option
    Input Text    id:username    ${username}
    Input Password    id:password    ${password}
    Click Element    css:input[value='user']
    Wait For Element Visible    css:.modal-body
    Click Button    okayBtn
    Wait Until Element Is Not Visible    css:.modal-body
    Select From List By Value    css:select.form-control    teach
    Select Checkbox    terms
    Checkbox Should Be Selected    terms
    Take Screenshot
