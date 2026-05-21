*** Settings ***
Resource    ../Keywords/Demokeywords.robot
Resource    ../TestData/CommonTestData.robot

Test Setup      Launch Browser
Test Teardown   Close Browser Session

*** Test Cases ***
TC03_Validation_Keywords***
    [Documentation]    Validation Keywords in RF
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
    # Checks text/content    <h2>Welcome to our store</h2>
    # Page Should Contain    Welcome to our store
    # # Used to verify whether a specific UI element exists //input[contains(@id,'small-searchterms')]  
    # Page Should Contain Element    //span[contains(text(),'Shopping cart')]

    Scroll Element Into View    //a[contains(text(),'Google+')] 
    Capture Page Screenshot   
    
    


    # mouse actions 
    # cliack element
    #double click Element
    #mouse up
    #mouse down
    Mouse Over    //ul[@class='top-menu']//a[contains(text(),'Computers')] #//check  xpath
    Click Element    //ul[@class='top-menu']//a[contains(text(),'Desktops')]   
    sleep    10s
    
    #keyboard action



    Input Text    //input[contains(@id,'small-searchterms')]    laptop
    Press Keys    //input[contains(@id,'small-searchterms')]    ENTER

    Page Should Contain    Search
    Sleep    30s  


TC04_keyboard_action
    [Documentation]    Validation Keywords in RF
    Click Login Link
    Input Text    id=Email    test@test.com

    Press Keys    id=Email    CTRL+A+BACKSPACE

TC05_Window_handling_example
    # Click a link that opens new window (example: Facebook link in footer if available)
    Click Element    //a[contains(text(),'Google+')]

    # Get all window handles
    ${handles}=    Get Window Handles

    # Switch to new window
    Switch Window    ${handles}[1]

    Sleep    2s

    # Verify new page
    Title Should Be    Google Workspace Updates: New community features for Google Chat and an update on Currents 

    Close Window

    Sleep    30s

    Switch Window    ${handles}[0]

Tc06_If_Else_Statement
    [Documentation]    if else statement
    Title Should Be    Demo Web Shop
     ${status}=    Run Keyword And Return Status
    ...    Page Should Contain Element
    ...    xpath=//a[text()='Register']

    IF    ${status}
        Log To Console    Register link is available
    ELSE
        Log To Console    Register link is NOT available
    END

    FOR    ${list}    IN    @{product_list}
        Log    ${list}
        
    END

    FOR    ${count}    IN RANGE    1    4
        Log To Console     ${count}
    END


    
 


  
    
