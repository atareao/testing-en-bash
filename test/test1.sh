#!/usr/bin/env bash
# -*- coding: utf-8 -*-

# Copyright (c) 2022 Lorenzo Carbonell <a.k.a. atareao>

# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:

# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.

# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

# --- 👇 A continuación los test unitarios que quieras hacer 👇 ---

## Aquí los Assert

testEquals(){
    assertEquals "Iguales" 1 1
}

testNotEquals(){
    assertNotEquals "Distintos" 1 2
}

testContains(){
    assertContains "Contiene" "Esto contiene un 1" 1
}

testNotContains(){
    assertNotContains "No contiene" "Esto contiene un 2" 1
}

testNull(){
    assertNull "Nulo" ""
}

testNotNull(){
    assertNotNull "No nulo" "nulo"
}

testTrue(){
    assertTrue "Cierto" 0
}

testTrue2(){
    assertTrue "Cierto" "${SHUNIT_TRUE}"
}

testTrue3(){
    assertTrue "Cierto" "[[ 2 -eq 2 ]]"
}

testTrue4(){
    assertTrue "Cierto" "[[ -d "${SCRIPT_DIR}/shunit2" ]]"
}

testFalse(){
    assertFalse "Falso" 1
}

testFail(){
    fail "Este test falla siempre"
}

testFailNotEquals(){
    failNotEquals "Este test falla siempre" 1 2
}

testSkippin(){
    assertTrue "Cierto" 0
    startSkipping
    fail "Este falla pero no se ejecutará"
    endSkipping
    assertTrue "Este si" 0
}

testSuma(){
    result=$(suma 1 22)
    assertEquals 23 "${result}"
}

testMultiplicacion(){
    result=$(multiplicacion 2 22)
    assertEquals 44 "${result}"
}

testApi301(){
    result=$(curl -s -o /dev/null -w "%{http_code}" -X GET "https://httpbin.org/status/301" -H  "accept: text/plain")
    assertEquals 301 "${result}"
}

testApi200(){
    result=$(curl -s -o /dev/null -w "%{http_code}" -X DELETE "https://httpbin.org/status/200" -H  "accept: text/plain")
    assertEquals 200 "${result}"
}

testSaludo(){
    result=$(curl -s -X GET "https://httpbin.org/base64/SG9sYQo%3D" -H  "accept: text/html")
    assertEquals "Hola" "${result}"
}

testUUID(){
    curl -s -X GET "https://httpbin.org/uuid" | grep uuid > /dev/null
    rs=$?
    assertTrue "${rs}"
}

# --- 👇 Aquí los scripts con el código a probar 👇 ---
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
oneTimeSetUp(){
    source "${SCRIPT_DIR}/../src/sample.sh"
}
# --- 👇 la librería que nos permite realizar las pruebas 👇 ---
# Load shUnit2
source "${SCRIPT_DIR}/shunit2/shunit2"
