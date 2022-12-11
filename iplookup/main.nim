# Learning Nim
# Part 2: CLI based IP lookup

import std/httpclient
import strformat
import json

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

let client = newHttpClient()
stdout.write("Enter an IP address: ")
let input = stdin.readLine()

let resp = client.request(
    BASE_URL & fmt"/{input}",
    httpMethod = HttpGet
)

let content = parseJson(resp.body)
var result: Result
try:
    result = to(content, Result)
except KeyError:
    echo "\n[!] Invalid IP given"
    quit(0)
let conn = result.connection

echo "================ IP ================"
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
echo "====================================="