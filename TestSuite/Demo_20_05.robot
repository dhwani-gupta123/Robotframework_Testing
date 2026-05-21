*** Settings ***
Resource    ../Keywords/Demokeywords.robot
Resource    ../TestData/CommonTestData.robot

Test Setup      Launch Browser
Test Teardown   Close Browser Session

*** Test Cases ***
TC01_Validating_Home_Page
    [Documentation]    This testcase verify home page title
    Verify Tilte Of Application Is Demo Web Shop
    Capture Page Screenshot

    # //h2[contains(text(),'Welcome to our store')]

    Page Should Contain    Welcome to our store 
    Sleep    20s  

    # //a[contains(@class,'ico-login')] 
    ${text}    Get Text    //a[contains(@class,'ico-login')]
    Log    ${text}
    # exact match validation
    Should Be Equal    ${text}    Log in
    # partial txt validation
    Should Contain    ${text}    Log

    # Mouse keywords   
    # Click Element    //a[contains(text(),'Log in')]

    # Title Should Be    Demo Web Shop. Login 
    # Capture Page Screenshot
    # Sleep    10s

    # Mouse Over    //ul[@class='top-menu']//a[contains(text(),'Computers')]
    # Click Element    //ul[@class='top-menu']//a[contains(text(),'Desktops')]
    # Capture Page Screenshot

    # keyboard actions
    # Input Text    //input[contains(@id,'small-searchterms')]    laptop
    # Press Keys    //input[contains(@id,'small-searchterms')]    ENTER
    # Capture Page Screenshot

    # Scroll Element Into View    //a[contains(text(),'Google+')]
    # Capture Page Screenshot
    # Wait Until Element Is Visible    locator         


    #window handling
    # Click Element    //a[contains(text(),'Google+')]

    # get all window handles
    # ${handles}=    Get Window Handles

    # # switch new window 
    # Switch Window    ${handles}[1]
    # Capture Page Screenshot
    # Sleep    10s

    # Title Should Be    Google Workspace Updates: New community features for Google Chat and an update on Currents 

    # Close Window

    # Switch Window    ${handles}[0]
    # Capture Page Screenshot
    ${Status}    Run Keyword And Return Status
    ...    page should contain    Register   

    IF    ${status}
        Log To Console    Register link is available
    ELSE
        Log To Console    Register link is NOT available
    END


    FOR    ${list}    IN    @{product_list}
        Log    ${list}
        
    END


    
    
