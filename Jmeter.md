# Jmeter dymanic parameters
## 1) use variables within your Test plan.

## 2) Define variables on the Test plan and allow there variables to be initialized with a property. EX: host = ${__P(host)}

## 3) Always use the variable within the Test plan

![image](https://github.com/sdeshpande22/hashicorp_vault/assets/54231317/ba216c6b-c65c-4dc1-83be-ad7f9f1d91ae)

## 4) jmeter -n -t your_script.jmx -Jhost=myapp.Test.com -Jport=8892 -Jprotocol=http -JsearchStartDate=20/05/2019 21:20:00 -JsearchEndDate=21/05/2019 21:20:00
