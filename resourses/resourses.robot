*** Settings ***
Library  SeleniumLibrary
Variables  ../resourses/variables.py

*** Keywords ***
Open browser and maximize
    [Arguments]  ${user_url}    ${user_browser}
    open browser  ${user_url}    ${user_browser}
    maximize browser window
    log  Starting test in ${user_browser}
    log  Test Url: ${user_url}

Close browser and log
    close browser
    log  Finish test.

Login to webpage
    [Arguments]  ${user-name}   ${user-password}
    input text  id:user-name    ${user-name}
    input password  id:password     ${user-password}
    click button  id:login-button
    log  Username:${user-name}, Password: ${user-password}



Logout from webpage
    click button  id:react-burger-menu-btn
    set browser implicit wait  3
    click link  id:logout_sidebar_link
    log     Logout from webpage

Change sorting method
    [Arguments]  ${sorting_method}
    select from list by value  xpath://*[@id="header_container"]/div[2]/div[2]/span/select   ${sorting method}

Add to cart
    [Arguments]  ${product_id}    ${product_price_id}   ${add_btn_id}
    set global variable  ${product_price_id}
    ${product_name}=   get text     xpath:${product_id}
    ${product_price}=   get text    xpath:${product_price_id}
    log  Product name: ${product_name}
    log  Product price: ${product_price}[1:]
    click button  ${add_btn_id}
    set browser implicit wait  3
    element text should be      class:btn_secondary     REMOVE

Open shopping cart
    click link  xpath://*[@id="shopping_cart_container"]/a
    capture page screenshot

Checkout shopping cart
    [Arguments]     ${product_price_id}
    click button  id:checkout
    input text  id:first-name   John
    input text  id:last-name    Doe
    input text  id:postal-code  01010
    click button  id:continue
    page should contain      Checkout: Overview
    log     page should contain:
    ${final_price}=     get text  xpath://*[@id="checkout_summary_container"]/div/div[1]/div[3]/div[2]/div[2]/div
    log  Final price: ${final_price}[1:]
    ${total_price}=     get text    xpath://*[@id="checkout_summary_container"]/div/div[2]/div[7]
    log  Total price: ${total_price}[1:]
    click button  id:finish
    page should contain  THANK YOU FOR YOUR ORDER
    click button  id:back-to-products
    location should be  https://www.saucedemo.com/inventory.html
    ${product_price}=   get text    xpath:${product_price_id}
    log  Product price: ${product_price}[1:]
    should be true  ${product_price}[1:] == ${final_price}[1:]

Check sorting items hilo-lohi
    select from list by value  xpath://*[@id="header_container"]/div[2]/div[2]/span/select      ${sort_hilo}
    ${elem} =   Get WebElements      xpath://*[@id="inventory_container"]/div
    FOR  ${item_hilo}  IN  @{elem}
        log  ${item_hilo.text}
    END
    select from list by value  xpath://*[@id="header_container"]/div[2]/div[2]/span/select      ${sort_lohi}
    ${elem} =   Get WebElements      xpath://*[@id="inventory_container"]/div
    FOR  ${item_lohi}  IN  @{elem}
        log  ${item_lohi.text}
    END
    should be true  '${item_hilo.text}[:10]' != '${item_lohi.text}[:10]'
    log  should be true  ${item_hilo.text}[:10] != ${item_lohi.text}[:10]

Check sorting items az-za
    select from list by value  xpath://*[@id="header_container"]/div[2]/div[2]/span/select      ${sort_az}
    ${elem} =   Get WebElements      xpath://*[@id="inventory_container"]/div
    FOR  ${item_az}  IN  @{elem}
        log  ${item_az.text}
    END
    select from list by value  xpath://*[@id="header_container"]/div[2]/div[2]/span/select      ${sort_za}
    ${elem} =   Get WebElements      xpath://*[@id="inventory_container"]/div
    FOR  ${item_za}  IN  @{elem}
        log  ${item_za.text}
    END
    should be true  '${item_az.text}[:10]' != '${item_za.text}[:10]'
    log  should be true  ${item_az.text}[:10] != '${item_za.text}[:10]


Check item name
    ${title0}=  get text  xpath://*[@id="item_4_title_link"]/div
    click link  xpath://*[@id="item_4_title_link"]
    ${title1}=  get text  xpath://*[@id="inventory_item_container"]/div/div/div[2]/div[1]
    should be true  '${title0}' == '${title1}'
    log  should be true  ${title0} == ${title1}


Check item description
    ${description0}=    get text    xpath://*[@id="inventory_container"]/div/div[1]/div[2]/div[1]/div
    click link  xpath://*[@id="item_4_title_link"]
    ${description1}=    get text    xpath://*[@id="inventory_item_container"]/div/div/div[2]/div[2]
    should be true  "${description0}" == "${description1}"
    log  should be true  ${description0} == ${description1}


Check item price
    ${price0}=  get text  xpath://*[@id="inventory_container"]/div/div[1]/div[2]/div[2]/div
    click link  xpath://*[@id="item_4_title_link"]
    ${price1}=  get text  xpath://*[@id="inventory_item_container"]/div/div/div[2]/div[3]
    should be true  ${price0}[1:] == ${price1}[1:]
    log  should be true  ${price0}[1:] == ${price1}[1:]