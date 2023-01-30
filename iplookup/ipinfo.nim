import std/httpclient
import strformat
import json
import os

const BASE_URL = "http://ipwho.is"

type Connection = object
    asn: int
    org: string
    isp: string
    domain: string

type Result = object
    ip: string
    country: string
    city: string
    postal: string
    calling_code: string
    capital: string
    connection: Connection

proc ask_ip(): string =
    stdout.write("Enter an IP addr: ")
    let input = stdin.readLine()
    return input

let client = newHttpClient()
var input: string
if paramCount() != 1:
    input = ask_ip()
else:
  input = paramStr(1)

#stdout.write("Enter an IP address: ")
#let input = stdin.readLine()

let resp = client.request(
    fmt"{BASE_URL}/{input}",
    httpMethod = HttpGet
)

let content = parseJson(resp.body)
var result: Result
try:
    result = content.to(Result)
except KeyError:
    echo "\n[!] Invalid IP given"
    quit(0)
let conn = result.connection

echo "\n============== DETAILS =============="
echo &"IP       : {result.ip}"
echo &"City     : {result.city}"
echo &"Country  : {result.country}"
echo &"Capital  : {result.capital}"
echo &"Postal Code : {result.postal}"
echo &"Calling Code: +{result.calling_code}"

echo "============ CONNECTION ============"
echo &"ASN: {conn.asn}"
echo &"ORG: {conn.org}"
echo &"ISP: {conn.isp}"
echo &"Domain: {conn.domain}"
echo "=====================================\n"
