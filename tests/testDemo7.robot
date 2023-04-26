*** Settings ***
Library     Collections
Library     RequestsLibrary


*** Variables ***
${base_url}     https://rahulshettyacademy.com
${book_id}
${book_name}    NewBook


*** Test Cases ***
Play around with dictionaries
    &{data} =    Create Dictionary    name=nam    course=robot    website=google.com
    Log    ${data}
    Dictionary Should Contain Key    ${data}    name
    Log    ${data}[name]
    ${url} =    Get From Dictionary    ${data}    website
    Log    ${url}

Add book into library db
    &{req_body} =    Create Dictionary    name=${book_name}    isbn=972212    aisle=324446    author=nam
    ${response} =    POST    ${base_url}/Library/Addbook.php    json=${req_body}    expected_status=200
    Log    ${response.json()}
    Dictionary Should Contain Key    ${response.json()}    ID
    ${book_id} =    Get From Dictionary    ${response.json()}    ID
    Set Global Variable    ${book_id}
    Log    ${book_id}
    Should Be Equal As Strings    successfully added    ${response.json()}[Msg]
    Status Should Be    200    ${response}

Get book detail
    ${get_response} =    POST    ${base_url}/Library/GetBook.php    params=ID=${book_id}    expected_status=200
    Log    ${get_response.json()}
    Should Be Equal As Strings    ${book_name}    ${get_response.json()}[0][book_name]

Delete book
    ${delete_req} =    Create Dictionary    ID=${book_ID}
    ${delete_resp} =    POST    ${base_url}/Library/DeleteBook.php    json=${delete_req}    expected_status=200
    Log    ${delete_resp.json()}
    Should Be Equal As Strings    book is successfully deleted    ${delete_resp.json()}[msg]
