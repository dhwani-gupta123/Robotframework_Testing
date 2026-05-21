*** Variables ***

${URL}     http://demowebshop.tricentis.com/
${HEADLESS}    False

# Login
${LOGIN_LINK}          //a[text()='Log in']
${EMAIL}               id=Email
${PASSWORD}            id=Password
${LOGIN_BUTTON}        xpath=//input[@value='Log in']

# Register
${REGISTER_LINK}       xpath=//a[text()='Register']
${FIRSTNAMETEXTBOX}     //input[contains(@id,'FirstName')]
${LASTNAMETEXTBOX}            id=LastName
${REG_EMAIL}           id=Email
${REG_PASSWORD}        id=Password
${CONFIRM_PASSWORD}   id=ConfirmPassword
${REGISTER_BUTTON}     id=register-button

# Search
${SEARCH_BOX}          id=small-searchterms
${SEARCH_BUTTON}       xpath=//input[@value='Search']

# Cart
${ADD_TO_CART}         xpath=//input[@value='Add to cart']
${SHOPPING_CART}       xpath=//span[text()='Shopping cart']

# Checkout
${CHECKOUT_BUTTON}     id=checkout
${COUNTRY}             id=BillingNewAddress_CountryId
${CITY}                id=BillingNewAddress_City
${ADDRESS1}            id=BillingNewAddress_Address1
${ZIP}                 id=BillingNewAddress_ZipPostalCode
${PHONE}               id=BillingNewAddress_PhoneNumber
${CONTINUE_BUTTON}     xpath=//input[@value='Continue']
