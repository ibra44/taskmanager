*** Settings ***
Library            SeleniumLibrary
Resource           resources/keywords.resource


*** Test Cases ***
Test create a task with invalid title
    [Documentation]            Verify the non creation of a task with an invalid title
    #${valid_desc}=             Generate Random String    3-450    [LETTERS]
    [Template]                 Verify Task Creation Rejected
    ${TITLE_02_CAR}            ${desc_30_car}
    ${TITLE_100_CAR}           ${desc_30_car}
    ${SPACES}                  ${desc_30_car}
    ${EMPTY}                   ${desc_30_car}
    
Test create a task with invalid description
    [Documentation]            Verify the non creation of a task with an invalid description
    [Template]                Verify Task Creation Rejected
    ${TITLE_11_CAR}            ${DESC_02_CAR}
    ${TITLE_11_CAR}            ${DESC_500_CAR}
    ${TITLE_11_CAR}            ${SPACES}
    ${TITLE_11_CAR}            ${EMPTY}

*** Keywords ***
Verify task creation rejected
    [Arguments]                            ${title}    ${description}
    [Teardown]                             Close Browser
    Open Login Page
    User Logged In
    Create A New Task
    Enter Task Title                       ${title}
    Enter Task Description                 ${description}
    Check Button Add Task Disabled