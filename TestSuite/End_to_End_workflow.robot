*** Settings ***
Library    SeleniumLibrary
Library    DateTime
Suite Teardown If you already have a valid account, set this to False and set ${LOGIN_EMAIL}/${LOGIN_PASSWORD}Suite Teardown    Close All Browsers
${DO_REGISTER}     True

${FIRST_NAME}      Sakshi
${LAST_NAME}       Gupta
${PASSWORD}        Tosca1234!

# If DO_REGISTER=False, provide existing credentials here
${LOGIN_EMAIL}     your_existing_email@yourdomain.test
${LOGIN_PASSWORD}  your_existing_password

# Address (example aligned with typical E2E flows)
${COUNTRY}         India
${CITY}            Noida
${ADDRESS1}        Sector 62
${ZIP}             201309
${PHONE}           9999999999

${PRODUCT_KEYWORD}    Computing and Internet
${PO_NUMBER}          12345


*** Test Cases ***
E2E_Login_To_Order_Successfully_In_One_Testcase
    [Documentation]    End-to-end: (Optional Register) -> Login -> Search product -> Add to cart -> Cart -> Checkout -> Purchase Order -> Confirm -> Success
    Open Browser    ${BASE_URL}    ${BROWSER}
    Maximize Browser Window
    Set Selenium Speed    0.1s

    ${email}=    Set Variable    ${LOGIN_EMAIL}
    ${pwd}=      Set Variable    ${LOGIN_PASSWORD}

    IF    '${DO_REGISTER}' == 'True'
        ${email}=    Create Unique Email
        Register New User    ${email}    ${PASSWORD}
        Click Link    css:a.ico-logout
        ${pwd}=    Set Variable    ${PASSWORD}
    END

    Login    ${email}    ${pwd}
    Search And Add Product To Cart    ${PRODUCT_KEYWORD}
    Go To Cart And Start Checkout
    Fill Billing Address And Continue
    Select Shipping Method Next Day Air
    Select Payment Method Purchase Order    ${PO_NUMBER}
    Confirm Order And Validate Success


*** Keywords ***
Create Unique Email
    ${ts}=    Get Current Date    result_format=%Y%m%d%H%M%S
    ${email}=    Set Variable    sakshi.gu${ts}@example.test
    [Return]    ${email}

Register New User
    [Arguments]    ${email}    ${password}
    Click Link    css:a.ico-register
    Wait Until Page Contains Element    id=FirstName    10s
    Input Text    id=FirstName    ${FIRST_NAME}
    Input Text    id=LastName     ${LAST_NAME}
    Input Text    id=Email        ${email}
    Input Password    id=Password         ${password}
    Input Password    id=ConfirmPassword  ${password}
    Click Button    id=register-button
    Wait Until Page Contains    Your registration completed    10s

Login
    [Arguments]    ${email}    ${password}
    Click Link    css:a.ico-login
    Wait Until Page Contains Element    id=Email    10s
    Input Text        id=Email        ${email}
    Input Password    id=Password     ${password}
    Click Button      xpath=//input[@type='submit']
    Wait Until Page Contains Element    css:a.account    10s

Search And Add Product To Cart
    [Arguments]    ${keyword}
    Wait Until Page Contains Element    id=small-searchterms    10s
    Input Text    id=small-searchterms    ${keyword}
    Click Button  css:input.button-1.search-box-button
    Wait Until Page Contains    Search    10s

    # Click product from search results
    Click Link    xpath=(//h2[@class='product-title']/a)[1]
    Wait Until Page Contains Element    xpath=//input[contains(@id,'add-to-cart-button') and contains(@class,'add-to-cart-button')]    10s

    Click Button    xpath=//input[contains(@id,'add-to-cart-button') and contains(@class,'add-to-cart-button')]

    # Validate add-to-cart notification content
    Wait Until Page Contains Element    xpath=//p[@class='content']    10s
    Page Should Contain    The product has been added to your shopping cart

Go To Cart And Start Checkout
    Click Link    css:a.ico-cart
    Wait Until Page Contains    Shopping cart    10s

    # Accept Terms of service and Checkout
    Click Element    id=termsofservice
    Click Button     xpath=//button[contains(@class,'checkout-button')]

Fill Billing Address And Continue
    # If address already exists, the page may show dropdown. We handle both.
    Wait Until Page Contains    Checkout    10s

    ${isDropdown}=    Run Keyword And Return Status    Page Should Contain Element    id=billing-address-select
    IF    ${isDropdown}
        # If saved address exists, select "New Address" if available
        Select From List By Label    id=billing-address-select    New Address
    END

    Run Keyword And Ignore Error    Input Text    id=BillingNewAddress_FirstName    ${FIRST_NAME}
    Run Keyword And Ignore Error    Input Text    id=BillingNewAddress_LastName     ${LAST_NAME}
    Run Keyword And Ignore Error    Input Text    id=BillingNewAddress_Email        dummy@example.test
    Run Keyword And Ignore Error    Select From List By Label    id=BillingNewAddress_CountryId    ${COUNTRY}
    Run Keyword And Ignore Error    Input Text    id=BillingNewAddress_City         ${CITY}
    Run Keyword And Ignore Error    Input Text    id=BillingNewAddress_Address1     ${ADDRESS1}
    Run Keyword And Ignore Error    Input Text    id=BillingNewAddress_ZipPostalCode ${ZIP}
    Run Keyword And Ignore Error    Input Text    id=BillingNewAddress_PhoneNumber  ${PHONE}

    Click Button    xpath=//div[@id='billing-buttons-container']//input[@value='Continue']
    Wait Until Page Contains    Shipping address    10s

    # Shipping address: continue (same as billing)
    Click Button    xpath=//div[@id='shipping-buttons-container']//input[@value='Continue']
    Wait Until Page Contains    Shipping method    10s

Select Shipping Method Next Day Air
    # Next Day Air is commonly available as a radio option
    ${clicked}=    Run Keyword And Return Status    Click Element    id=shippingoption_1
    IF    not ${clicked}
        Click Element    xpath=//label[contains(.,'Next Day Air')]/preceding-sibling::input
    END
    Click Button    xpath=//div[@id='shipping-method-buttons-container']//input[@value='Continue']
    Wait Until Page Contains    Payment method    10s

Select Payment Method Purchase Order
    [Arguments]    ${po_number}
    ${clicked}=    Run Keyword And Return Status    Click Element    id=paymentmethod_3
    IF    not ${clicked}
        Click Element    xpath=//label[contains(.,'Purchase Order')]/preceding-sibling::input
    END
    Click Button    xpath=//div[@id='payment-method-buttons-container']//input[@value='Continue']
    Wait Until Page Contains    Payment information    10s

    # Purchase order number
    Run Keyword And Ignore Error    Input Text    id=PurchaseOrderNumber    ${po_number}

    Click Button    xpath=//div[@id='payment-info-buttons-container']//input[@value='Continue']
    Wait Until Page Contains    Confirm order    10s

Confirm Order And Validate Success
    Click Button    xpath=//div[@id='confirm-order-buttons-container']//input[@value='Confirm']
    Wait Until Page Contains    Thank you    15s
    Page Should Contain    Your order has been successfully processed!
    Page Should Contain Element    xpath=//div[contains(@class,'order-number')]

*** Variables ***
${BASE_URL}        http://demowebshop.tricentis.com/
${BROWSER}         chrome

