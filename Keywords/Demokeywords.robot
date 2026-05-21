*** Settings ***
Library    SeleniumLibrary

Resource   ../ObjectRepository/DemoObjects.robot

*** Keywords ***

*** Keywords ***
Launch Browser
    ${options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys

    IF    ${HEADLESS}
        Call Method    ${options}    add_argument    "--headless=new"
        Call Method    ${options}    add_argument    "--no-sandbox"
        Call Method    ${options}    add_argument    "--disable-dev-shm-usage"
        Call Method    ${options}    add_argument    "--window-size=1920,1080"
    END

    Open Browser    ${URL}    chrome    options=${options}
    Set Selenium Timeout    10s

Close Browser Session
    Close Browser

Click Login Link
    Click Element    ${LOGIN_LINK}

Enter Login Credentials
    [Arguments]    ${email_1}    ${password_1}
    Input Text     ${EMAIL}      ${email_1}
    Input Password    ${PASSWORD}   ${password_1}
    RETURN    ${email}

Click Login Button
    Click Button    ${LOGIN_BUTTON}

Verify Login Successful
    Page Should Contain    Log out

Navigate To Registration Link
    Click Element    ${REGISTER_LINK}

Provide Already Existing Email Id
    [Arguments]    ${firstname}    ${lastname}    ${email}    ${password}
    Wait Until Element Is Visible    ${FIRSTNAMETEXTBOX}   10s 
    Input Text       ${FIRSTNAMETEXTBOX}      ${firstname}
    Input Text       ${LASTNAMETEXTBOX}       ${lastname}
    Input Text       ${REG_EMAIL}      ${email}
    Input Password   ${REG_PASSWORD}   ${password}
    Input Password   ${CONFIRM_PASSWORD}   ${password}
    Click Button     ${REGISTER_BUTTON}

Verified that User Is Unable To Register With Already Resitered Email Id
    ${status}=    Run Keyword And Return Status
    ...    Page Should Contain    The specified email already exists

    IF    ${status}
        Log To Console    The specified email already exists.Please register with another email ID.  
    END

Register New User
    [Arguments]    ${firstname}    ${lastname}    ${email}    ${password}

    
    Wait Until Element Is Visible    ${FIRSTNAMETEXTBOX}   10s 
    Input Text       ${FIRSTNAMETEXTBOX}      ${firstname}
    Input Text       ${LASTNAMETEXTBOX}       ${lastname}
    Input Text       ${REG_EMAIL}      ${email}
    ${pass}=    Run Keyword And Return Status
    ...    Input Password   ${REG_PASSWORD}   ${password}
    ${confirmpass}=    Run Keyword And Return Status
    ...    Input Password   ${CONFIRM_PASSWORD}   ${password}
    IF    ${pass} == ${confirmpass} 
        Click Button     ${REGISTER_BUTTON}
    ELSE
        Page Should Contain    The password and confirmation password do not match.
    END
    Page Should Contain    Your registration completed
    

Search Product
    [Arguments]    ${product}

    Input Text      ${SEARCH_BOX}      ${product}
    Click Button    ${SEARCH_BUTTON}

Add Product To Cart
    Click Button    ${ADD_TO_CART}

Open Shopping Cart
    Click Element   ${SHOPPING_CART}

Proceed To Checkout
    Click Element   ${CHECKOUT_BUTTON}

Fill Billing Address
    Select From List By Label    ${COUNTRY}    India
    Input Text    ${CITY}        Noida
    Input Text    ${ADDRESS1}    Sector 62
    Input Text    ${ZIP}         201309
    Input Text    ${PHONE}       9999999999

    Click Button    ${CONTINUE_BUTTON}

Verify Tilte Of Application is Demo Web Shop
    Title Should Be    Demo Web Shop

Wait Until Login Page Visible
    Wait Until Element Is Visible    //strong[normalize-space()='Returning Customer']    20s
