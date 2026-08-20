*** Settings ***
Library    SeleniumLibrary
Library    String

*** Variables ***
${BASE_URL}                  https://taskmanager.stl-training.fr
${EMAIL}                     jorge.penaramirez2026@campus-eni.fr
${PASSWORD}                  jorge1234

#Valid values for title and descriptions of a task
${TITLE_11_CAR}              Lorem ipsum
${desc_30_car}               Lorem ipsum dolor sit gravida.

#Invalid values for title
${TITLE_02_CAR}              Ta
${TITLE_100_CAR}             Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus a bibendum ligula. Phasellus nam.
${SPACES}                    ${SPACE * 3}
#Invalid values for description
${DESC_500_CAR}              Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed quis augue eget urna accumsan faucibus sed ac urna. In ut enim auctor, semper erat in, rhoncus lorem. Aliquam finibus viverra lectus, quis pulvinar metus pharetra vel. Mauris et faucibus enim, vel consequat quam. Phasellus et volutpat justo. Nam cursus erat massa, sed posuere sem rutrum vitae. Vestibulum tempor turpis sem, vitae pulvinar nulla cursus eu. Nunc leo justo, consectetur nec lobortis ac, fringilla et velit. Nulla massa nunc.
${DESC_02_CAR}               Ac

*** Keywords ***
Open Login Page
    Open Browser                       ${BASE_URL}        firefox
    
User Logged In
    [Documentation]                    Authenticate a user on the website
    Input Text                         id=mat-input-0                              ${EMAIL}
    Input Password                     id=mat-input-1                              ${PASSWORD}
    Click Button                       //button[.//span[text()='Login']]
    Wait Until Page Contains           Tasks

Create a new task
    Wait Until Element Is Visible        //taskmanager-tasks/button[@mat-fab]
    Click Button                        //taskmanager-tasks/button[@mat-fab]

Enter task title
    [Arguments]                          ${title}
    Input Text                           id=mat-input-2                       ${title}
    Wait Until Element Is Visible        id=mat-input-2

Enter task description
    [Arguments]                          ${description}
    Wait Until Element Is Visible        id=mat-input-3
    Input Text                           id=mat-input-3                        ${description}

Add Task
    Click Button                        //button[.//span[text()='Add Task']]
    
Check task created
    [Arguments]                          ${title}    ${description}
    Wait Until Page Contains Element    //mat-list-item
    Element Should Contain              (//mat-list-item)[1]                 ${title}
    Element Should Contain              (//mat-list-item)[1]                 ${description}

Check button add task disabled     
    Element Should Be Disabled           //button[.//span[text()='Add Task']]

Logout
    Click Button                         //button[.//mat-icon[text()='logout']]



