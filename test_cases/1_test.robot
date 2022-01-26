*** Settings ***
Documentation    Keywords and Variables in separate files in directory resourses
Library     SeleniumLibrary
Resource  ../resourses/resourses.robot
Variables  ../resourses/variables.py


*** Test Cases ***
Standart user purchase test case
    [Tags]    login logout add_to_cart checkout
#    Provided precondition   User is already signed up
#    When user log in to website he is able to choose and buy items
#    Then after adding items user is able to checkout
    [Setup]    Open browser and maximize    ${url}  ${browser}
    [Teardown]  Close browser and log
    Login to webpage  ${standard_user}  ${password}
    location should be  https://www.saucedemo.com/inventory.html
#   This will change sorting method of visualization of items on the page
    Add to cart  //*[@id="item_5_title_link"]/div    //*[@id="inventory_container"]/div/div[4]/div[2]/div[2]/div     //*[@id="add-to-cart-sauce-labs-fleece-jacket"]
    Open shopping cart
#   This will complete purshasing item from the cart
    Checkout shopping cart      //*[@id="inventory_container"]/div/div[4]/div[2]/div[2]/div
    Logout from webpage

Locked out user login test case
    [Tags]    login locked_out_user
#    Provided precondition   User is already signed up
#    When user's account is locked up
#    Then check if user is able to log in
    [Setup]    Open browser and maximize    ${url}  ${browser}
    [Teardown]  Close browser and log
    Login to webpage  ${locked_out_user}  ${password}
    page should contain  Sorry, this user has been locked out.


Problem user sorting hilo-lohi test case
    [Tags]  login   sorting     problem_user    hilo-lohi
#    Provided precondition   User is already signed up
    [Setup]    Open browser and maximize    ${url}  ${browser}
    [Teardown]  Close browser and log
    Login to webpage  ${problem_user}  ${password}
    location should be  https://www.saucedemo.com/inventory.html
#   This will check if item's grid changes when sorting is applied
    Check sorting items hilo-lohi


Problem user sorting az-za test case
    [Tags]  login   sorting     problem_user    hilo-lohi
#    Provided precondition   User is already signed up
    [Setup]    Open browser and maximize    ${url}  ${browser}
    [Teardown]  Close browser and log
    Login to webpage  ${problem_user}  ${password}
    location should be  https://www.saucedemo.com/inventory.html
#   This will check if item's grid changes when sorting is applied
    Check sorting items az-za


Problem user check item name test case
    [Tags]  item_name     problem_user
#    Provided precondition   User is already signed up
    [Setup]    Open browser and maximize    ${url}  ${browser}
    [Teardown]  Close browser and log
    Login to webpage  ${problem_user}  ${password}
    location should be  https://www.saucedemo.com/inventory.html
#   This will check if name of item, displayed
#   on main page corresponds to name of item, displayed
#   on page of an item
    Check item name


Problem user check item description test case
    [Tags]  item_description     problem_user
#    Provided precondition   User is already signed up
    [Setup]    Open browser and maximize    ${url}  ${browser}
    [Teardown]  Close browser and log
    Login to webpage  ${problem_user}  ${password}
    location should be  https://www.saucedemo.com/inventory.html
#   This will check if descriptionof item, displayed
#   on main page corresponds to  descriptionof item, displayed
#   on page of an item
    Check item description


Problem user check item price test case
    [Tags]  item_price     problem_user
#    Provided precondition   User is already signed up
    [Setup]    Open browser and maximize    ${url}  ${browser}
    [Teardown]  Close browser and log
    Login to webpage  ${problem_user}  ${password}
    location should be  https://www.saucedemo.com/inventory.html
#   This will check if price of item, displayed
#   on main page corresponds to price of item, displayed
#   on page of an item
    Check item price


Problem user purchase test case
     [Tags]    login  add_to_cart checkout   problem_user
#    Provided precondition   User is already signed up
#    When user log in to website he is able to choose and buy items
#    Then after adding items user is able to checkout
    [Setup]    Open browser and maximize    ${url}  ${browser}
    [Teardown]  Close browser and log
    Login to webpage  ${standard_user}  ${password}
    location should be  https://www.saucedemo.com/inventory.html
#   This will add 1 item to cart
    Add to cart  //*[@id="item_5_title_link"]/div     //*[@id="inventory_container"]/div/div[1]/div[2]/div[2]/div     //*[@id="add-to-cart-sauce-labs-fleece-jacket"]
    Open shopping cart
#   This will complete purshasing item from the cart
    Checkout shopping cart      //*[@id="inventory_container"]/div/div[4]/div[2]/div[2]/div
