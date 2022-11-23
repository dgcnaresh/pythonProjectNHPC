*** Settings ***
Library  RequestsLibrary
Library    Collections
Library    OperatingSystem
Library  json
Library    JSONLibrary

*** Variables ***
${base_url}  http://localhost:8080
${item1}    Set Variable    10
${item2}    Set Variable    0.8
${item3}    Set Variable    0.5
${item4}    Set Variable    0.367
${item5}    Set Variable    0.05

${Male}    Set Variable    0
${Female}    Set Variable    500

*** Test Cases ***
Post_Hero_data_Tax_Relief
    create session  mysession   ${base_url}
    ${body}=    Load JSON from file    ${CURDIR}/Applicationfiles/data.json
    ${header}=  create dictionary   Content-Type=application/json
    ${responsevalue}=   post request  mysession  /calculator/insert  data=${body}  headers=${header}

    log to console  ${item1}
    log to console  ${responsevalue.status_code}
    log to console  ${responsevalue.content}
    log to console  ${responsevalue.headers}

    #AC1: Single record of a working class hero should consist of Natural Id (natid), Name, Gender, Birthday, Salary and Tax paid
    #Validations
    ${status_code}=  convert to string  ${responsevalue.status_code}
    should be equal  ${status_code}  202

     ${responsevalue}=  Get Request  mysession  /calculator/taxRelief
    #to validate the content of the response body
    log to console  ${responsevalue}
    #Validation point to validate the hero id added in the database.
    ${response_body}=  convert to string   ${responsevalue.content}
    should contain     ${response_body}    s01






