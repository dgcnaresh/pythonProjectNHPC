*** Settings ***
Library  RequestsLibrary
Library    Collections
Library    OperatingSystem
Library  json
Library    JSONLibrary

*** Variables ***
${base_url}  http://localhost:8080
#${city}  Delhi

# (2) As the Clerk, I should be able to insert more than one working  #class hero into database via an API
*** Test Cases ***
Post_Hero_InsertMultipledata
    create session  mysession   ${base_url}
    ${body}=    Load JSON from file    ${CURDIR}/Applicationfiles/insertmultipledata.json
    ${header}=  create dictionary   Content-Type=application/json
    ${responsevalue}=   post request  mysession  /calculator/insertMultiple  data=${body}  headers=${header}

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
    should contain     ${response_body}    S0000029
    should contain     ${response_body}    S0000030






