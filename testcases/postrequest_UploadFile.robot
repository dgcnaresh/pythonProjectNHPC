*** Settings ***
Library  RequestsLibrary
Library    Collections
Library    OperatingSystem

*** Variables ***
${base_url}  http://localhost:8080
${city}  Delhi


*** Test Cases ***
Upload csv file
    create session  mysession   ${base_url}
    ${file}=    GET FILE FOR STREAMING UPLOAD    ${CURDIR}/Applicationfiles/Sample-Spreadsheet-10-rows.csv
    ${files}=    CREATE DICTIONARY    file    ${file}
    ${Header}     create dictionary     accept=application/json
    ${resp}    POST ON SESSION    mysession    /calculator/uploadLargeFileForInsertionToDatabase    headers=${Header}    files=${files}

 #Validations
    ${status_code}=  convert to string  ${resp.status_code}
    should be equal  ${status_code}  200

    ${bodyverification}=  convert to string  ${resp.content}
    should be equal  ${bodyverification}  Successfully uploaded

    ${responsevalue}=  Get Request  mysession  /calculator/taxRelief
    #to validate the content of the response body
    log to console  ${responsevalue}
    #Validation point to validate the hero id added in the database.
    ${response_body}=  convert to string   ${responsevalue.content}
    should contain     ${response_body}    s0008
    should contain     ${response_body}    s0009
    should contain     ${response_body}    s00010






