# Learning Nim
# Part 2: CLI based IP lookup

import std/httpclient
import strformat
import json

const BASE_URL = "http://ipwho.is"

type
    Connection = object
        asn: int
        org: string
        isp: string
        domain: string

# type
#     Security = object
#         anonymous: bool
#         proxy: bool
#         vpn: bool
#         tor: bool
#         hosting: bool

type
    Result = object
        ip: string
        country: string
        city: string
        postal: string
        calling_code: string
        capital: string
        connection: Connection
        # security: Security

var client = newHttpClient()
stdout.write("Enter an IP address: ")
var input = stdin.readLine()

var resp = client.getContent(BASE_URL & fmt"/{input}")
var content = parseJson(resp)
var result = to(content, Result)
var conn = result.connection

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