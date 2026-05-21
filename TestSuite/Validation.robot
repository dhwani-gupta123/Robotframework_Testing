*** Settings ***
Resource    ../Keywords/Demokeywords.robot
Resource    ../TestData/CommonTestData.robot

Test Setup      Launch Browser
Test Teardown   Close Browser Session

*** Test Cases ***
TC03_Validation_Keywords***
    [Documentation]    Validation Keywords in RF
    [Tags]    TC    Validation
    Verify Tilte Of Application Is Demo Web Shop
    Capture Page Screenshot
    Click Login Link
    Sleep    20s     
    Wait Until Element Is Visible    //h1[contains(text(),'Welcome, Please Sign In!')]    20s
    Element Should Be Visible    //h1[contains(text(),'Welcome, Please Sign In!')]  
    ${text}=    Get Text    xpath=//a[@class='ico-login']
    Log    ${text}
    # Exact match validation
    Should Be Equal    ${text}    Log in 
    # Partial text validation
    Should Contain    ${text}    Log
    # Verify exact text of specific element
    Element Text Should Be    xpath=//a[@class='ico-login']    Log in
    Scroll Element Into View    //a[contains(text(),'Google+')] 
    Capture Page Screenshot   
    Mouse Over    //ul[@class='top-menu']//a[contains(text(),'Computers')] 
    Click Element    //ul[@class='top-menu']//a[contains(text(),'Desktops')]   
    sleep    10s
    Input Text    //input[contains(@id,'small-searchterms')]    laptop
    Press Keys    //input[contains(@id,'small-searchterms')]    ENTER
    Page Should Contain    Search
    Sleep    30s  
