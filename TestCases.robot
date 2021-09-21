*** Settings ***
Library     Collections
Library     Process
Library     RequestsLibrary
Library     JSONLibrary
Library     os

*** Variables ***
${cert_path} =  C:/Pramila/Certs/client_cert.pem
${key_path} =  C:/Pramila/Certs/Client_Private.key
${headers} =  {'accept': 'application/json',   'x-abbtoken': '90005bd7-717f-4c93-8d4e-3a5b57794a44'}
${url}=   https://192.168.2.5:5001

*** Test Cases ***
Calling GET method


        @{client certs}=  create list  ${cert_path}  ${key_path}
        ${session}      Create Client Cert Session   alias=sess   url=${url}  headers=${headers}  client_certs=${client certs}  verify=${False}

        ${resp}=    GET On Session    sess   url=/api/v1     expected_status=200
        Status Should Be    200    ${resp}

        ${firmwareVersion}=   get value from json  ${resp.json()}  $.firmwareVersion
        log to console  ${resp.json()}
        Should Contain  ${firmwareVersion}  1.20



