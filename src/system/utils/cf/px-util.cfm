<cfprocessingDirective pageencoding="utf-8">
<cfset setEncoding("form","utf-8")> 

<!--- http://www.bennadel.com/blog/124-ask-ben-converting-a-query-to-an-array.htm --->
<cffunction 
    name       ="QueryToArray" 
    access     ="public" 
    returntype ="array" 
    output     ="false"
    hint       ="Transforma uma query em uma array de structs.">
 
    <!--- Define arguments. --->
    <cfargument 
        name     ="Data" 
        type     ="query" 
        required ="yes"/>
 
    <cfscript>
 
        // Define the local scope.
        var LOCAL = StructNew();
 
        // Get the column names as an array.
        LOCAL.Columns = ListToArray( ARGUMENTS.Data.ColumnList );
 
        // Create an array that will hold the query equivalent.
        LOCAL.QueryArray = ArrayNew( 1 );
 
        // Loop over the query.
        for (LOCAL.RowIndex = 1 ; LOCAL.RowIndex LTE ARGUMENTS.Data.RecordCount ; LOCAL.RowIndex = (LOCAL.RowIndex + 1)){
 
            // Create a row structure.
            LOCAL.Row = StructNew();
 
            // Loop over the columns in this row.
            for (LOCAL.ColumnIndex = 1 ; LOCAL.ColumnIndex LTE ArrayLen( LOCAL.Columns ) ; LOCAL.ColumnIndex = (LOCAL.ColumnIndex + 1)){
 
                // Get a reference to the query column.                
                LOCAL.ColumnName = LOCAL.Columns[ LOCAL.ColumnIndex ];
                //LOCAL.ColumnName = lCase(LOCAL.Columns[ LOCAL.ColumnIndex ]); 
 
                // Store the query cell value into the struct by key.
                LOCAL.Row[ LOCAL.ColumnName ] = ARGUMENTS.Data[ LOCAL.ColumnName ][ LOCAL.RowIndex ];
 
            }
 
            // Add the structure to the query array.
            ArrayAppend( LOCAL.QueryArray, LOCAL.Row );
 
        }
 
        // Return the array equivalent.
        return( LOCAL.QueryArray );
 
    </cfscript>
    
</cffunction>

<!---
Serialize and deserialize JSON data into native ColdFusion objects
http://www.epiphantastic.com/cfjson/

Authors: Jehiah Czebotar (jehiah@gmail.com)
         Thomas Messier  (thomas@epiphantastic.com)

Version: 1.9 February 20, 2008
---> 
<cffunction 
    name       ="decode" 
    access     ="remote" 
    returntype ="any" 
    output     ="no"
    hint       ="Converts data frm JSON to CF format">

    <cfargument 
        name     ="data" 
        type     ="string" 
        required ="Yes"/>
    
    <!--- DECLARE VARIABLES --->
    <cfset var ar = ArrayNew(1) />
    <cfset var st = StructNew() />
    <cfset var dataType = "" />
    <cfset var inQuotes = false />
    <cfset var startPos = 1 />
    <cfset var nestingLevel = 0 />
    <cfset var dataSize = 0 />
    <cfset var i = 1 />
    <cfset var skipIncrement = false />
    <cfset var j = 0 />
    <cfset var char = "" />
    <cfset var dataStr = "" />
    <cfset var structVal = "" />
    <cfset var structKey = "" />
    <cfset var colonPos = "" />
    <cfset var qRows = 0 />
    <cfset var qCol = "" />
    <cfset var qData = "" />
    <cfset var curCharIndex = "" />
    <cfset var curChar = "" />
    <cfset var result = "" />
    <cfset var unescapeVals = "\\,\"",\/,\b,\t,\n,\f,\r" />
    <cfset var unescapeToVals = "\,"",/,#Chr(8)#,#Chr(9)#,#Chr(10)#,#Chr(12)#,#Chr(13)#" />
    <cfset var unescapeVals2 = '\,",/,b,t,n,f,r' />
    <cfset var unescapetoVals2 = '\,",/,#Chr(8)#,#Chr(9)#,#Chr(10)#,#Chr(12)#,#Chr(13)#' />
    <cfset var dJSONString = "" />
    
    <cfset var _data = Trim(arguments.data) />
    
    <!--- NUMBER --->
    <cfif IsNumeric(_data)>
        <cfreturn _data />

    <!--- NULL --->
    <cfelseif _data EQ "null">
        <cfreturn "" />
    
    <!--- BOOLEAN --->
    <cfelseif ListFindNoCase("true,false", _data)>
        <cfreturn _data />
    
    <!--- EMPTY STRING --->
    <cfelseif _data EQ "''" OR _data EQ '""'>
        <cfreturn "" />

    <!--- STRING --->
    <cfelseif ReFind('^"[^\\"]*(?:\\.[^\\"]*)*"$', _data) EQ 1 OR ReFind("^'[^\\']*(?:\\.[^\\']*)*'$", _data) EQ 1>
        <cfset _data = mid(_data, 2, Len(_data)-2) />
        <!--- If there are any \b, \t, \n, \f, and \r, do extra processing
            (required because ReplaceList() won't work with those) --->
        <cfif Find("\b", _data) OR Find("\t", _data) OR Find("\n", _data) OR Find("\f", _data) OR Find("\r", _data)>
            <cfset curCharIndex = 0 />
            <cfset curChar =  ""/>
            <cfset dJSONString = createObject("java", "java.lang.StringBuffer").init("") />
            <cfloop condition="true">
                <cfset curCharIndex = curCharIndex + 1 />
                <cfif curCharIndex GT len(_data)>
                    <cfbreak />
                <cfelse>
                    <cfset curChar = mid(_data, curCharIndex, 1) />
                    <cfif curChar EQ "\">
                        <cfset curCharIndex = curCharIndex + 1 />
                        <cfset curChar = mid(_data, curCharIndex,1) />
                        <cfset pos = listFind(unescapeVals2, curChar) />
                        <cfif pos>
                            <cfset dJSONString.append(ListGetAt(unescapetoVals2, pos)) />
                        <cfelse>
                            <cfset dJSONString.append("\" & curChar) />
                        </cfif>
                    <cfelse>
                        <cfset dJSONString.append(curChar) />
                    </cfif>
                </cfif>
            </cfloop>
            
            <cfreturn dJSONString.toString() />
        <cfelse>
            <cfreturn ReplaceList(_data, unescapeVals, unescapeToVals) />
        </cfif>
    
    <!--- ARRAY, STRUCT, OR QUERY --->
    <cfelseif ( Left(_data, 1) EQ "[" AND Right(_data, 1) EQ "]" )
        OR ( Left(_data, 1) EQ "{" AND Right(_data, 1) EQ "}" )>
        
        <!--- Store the data type we're dealing with --->
        <cfif Left(_data, 1) EQ "[" AND Right(_data, 1) EQ "]">
            <cfset dataType = "array" />
        <cfelseif ReFindNoCase('^\{"recordcount":[0-9]+,"columnlist":"[^"]+","data":\{("[^"]+":\[[^]]*\],?)+\}\}$', _data, 0) EQ 1>
            <cfset dataType = "query" />
        <cfelse>
            <cfset dataType = "struct" />
        </cfif>
        
        <!--- Remove the brackets --->
        <cfset _data = Trim( Mid(_data, 2, Len(_data)-2) ) />
        
        <!--- Deal with empty array/struct --->
        <cfif Len(_data) EQ 0>
            <cfif dataType EQ "array">
                <cfreturn ar />
            <cfelse>
                <cfreturn st />
            </cfif>
        </cfif>
        
        <!--- Loop through the string characters --->
        <cfset dataSize = Len(_data) + 1 />
        <cfloop condition="#i# LTE #dataSize#">
            <cfset skipIncrement = false />
            <!--- Save current character --->
            <cfset char = Mid(_data, i, 1) />
            
            <!--- If char is a quote, switch the quote status --->
            <cfif char EQ '"'>
                <cfset inQuotes = NOT inQuotes />
            <!--- If char is escape character, skip the next character --->
            <cfelseif char EQ "\" AND inQuotes>
                <cfset i = i + 2 />
                <cfset skipIncrement = true />
            <!--- If char is a comma and is not in quotes, or if end of string, deal with data --->
            <cfelseif (char EQ "," AND NOT inQuotes AND nestingLevel EQ 0) OR i EQ Len(_data)+1>
                <cfset dataStr = Mid(_data, startPos, i-startPos) />
                
                <!--- If data type is array, append data to the array --->
                <cfif dataType EQ "array">
                    <cfset arrayappend( ar, decode(dataStr) ) />
                <!--- If data type is struct or query... --->
                <cfelseif dataType EQ "struct" OR dataType EQ "query">
                    <cfset dataStr = Mid(_data, startPos, i-startPos) />
                    <cfset colonPos = Find('":', dataStr) />
                    <cfif colonPos>
                        <cfset colonPos = colonPos + 1 />   
                    <cfelse>
                        <cfset colonPos = Find(":", dataStr) /> 
                    </cfif>
                    <cfset structKey = Trim( Mid(dataStr, 1, colonPos-1) ) />
                    
                    <!--- If needed, remove quotes from keys --->
                    <cfif Left(structKey, 1) EQ "'" OR Left(structKey, 1) EQ '"'>
                        <cfset structKey = Mid( structKey, 2, Len(structKey)-2 ) />
                    </cfif>
                    
                    <cfset structVal = Mid( dataStr, colonPos+1, Len(dataStr)-colonPos ) />
                    
                    <!--- If struct, add to the structure --->
                    <cfif dataType EQ "struct">
                        <cfset StructInsert( st, structKey, decode(structVal) ) />
                    
                    <!--- If query, build the query --->
                    <cfelse>
                        <cfif structKey EQ "recordcount">
                            <cfset qRows = decode(structVal) />
                        <cfelseif structKey EQ "columnlist">
                            <cfset st = QueryNew( decode(structVal) ) />
                            <cfif qRows>
                                <cfset QueryAddRow(st, qRows) />
                            </cfif>
                        <cfelseif structKey EQ "data">
                            <cfset qData = decode(structVal) />
                            <cfset ar = StructKeyArray(qData) />
                            <cfloop from="1" to="#ArrayLen(ar)#" index="j">
                                <cfloop from="1" to="#st.recordcount#" index="qRows">
                                    <cfset qCol = ar[j] />
                                    <cfset QuerySetCell(st, qCol, qData[qCol][qRows], qRows) />
                                </cfloop>
                            </cfloop>
                        </cfif>
                    </cfif>
                </cfif>
                
                <cfset startPos = i + 1 />
            <!--- If starting a new array or struct, add to nesting level --->
            <cfelseif "{[" CONTAINS char AND NOT inQuotes>
                <cfset nestingLevel = nestingLevel + 1 />
            <!--- If ending an array or struct, subtract from nesting level --->
            <cfelseif "]}" CONTAINS char AND NOT inQuotes>
                <cfset nestingLevel = nestingLevel - 1 />
            </cfif>
            
            <cfif NOT skipIncrement>
                <cfset i = i + 1 />
            </cfif>
        </cfloop>
        
        <!--- Return appropriate value based on data type --->
        <cfif dataType EQ "array">
            <cfreturn ar />
        <cfelse>
            <cfreturn st />
        </cfif>
        
    <!--- INVALID JSON --->
    <cfelse>
        <cfreturn 'Invalid JSON - The document you are trying to decode is not in valid JSON format'>
        <!--- <cfthrow message="Invalid JSON" detail="The document you are trying to decode is not in valid JSON format" /> --->
    </cfif>
</cffunction>


<!--- CONVERTS DATA FROM CF TO JSON FORMAT --->
<cffunction 
    name       ="encode" 
    access     ="remote" 
    returntype ="string" 
    output     ="No"
    hint       ="Converts data from CF to JSON format">

    <cfargument 
        name     ="data" 
        type     ="any" 
        required ="Yes"/>

    <cfargument 
        name     ="queryFormat" 
        type     ="string" 
        required ="No" 
        default  ="query"/> <!-- query or array -->

    <cfargument 
        name     ="queryKeyCase" 
        type     ="string" 
        required ="No" 
        default  ="lower"/> <!-- lower or upper -->

    <cfargument 
        name     ="stringNumbers" 
        type     ="boolean" 
        required ="No" 
        default  =false>

    <cfargument 
        name     ="formatDates" 
        type     ="boolean" 
        required ="No" 
        default  =false>

    <cfargument 
        name     ="columnListFormat" 
        type     ="string" 
        required ="No" 
        default  ="string"> <!-- string or array -->
    
    <!--- VARIABLE DECLARATION --->
    <cfset var jsonString = "" />
    <cfset var tempVal = "" />
    <cfset var arKeys = "" />
    <cfset var colPos = 1 />
    <cfset var i = 1 />
    <cfset var column = ""/>
    <cfset var datakey = ""/>
    <cfset var recordcountkey = ""/>
    <cfset var columnlist = ""/>
    <cfset var columnlistkey = ""/>
    <cfset var dJSONString = "" />
    <cfset var escapeToVals = "\\,\"",\/,\b,\t,\n,\f,\r" />
    <cfset var escapeVals = "\,"",/,#Chr(8)#,#Chr(9)#,#Chr(10)#,#Chr(12)#,#Chr(13)#" />
    
    <cfset var _data = arguments.data />

    <!--- BOOLEAN --->
    <cfif IsBoolean(_data) AND NOT IsNumeric(_data) AND NOT ListFindNoCase("Yes,No", _data)>
        <cfreturn LCase(ToString(_data)) />
        
    <!--- NUMBER --->
    <cfelseif NOT stringNumbers AND IsNumeric(_data) AND NOT REFind("^0+[^/.]",_data)>
        <cfreturn ToString(_data) />
    
    <!--- DATE --->
    <cfelseif IsDate(_data) AND arguments.formatDates>
        <cfreturn '"#DateFormat(_data, "medium")# #TimeFormat(_data, "medium")#"' />
    
    <!--- STRING --->
    <cfelseif IsSimpleValue(_data)>
        <cfreturn '"' & ReplaceList(_data, escapeVals, escapeToVals) & '"' />
    
    <!--- ARRAY --->
    <cfelseif IsArray(_data)>
        <cfset dJSONString = createObject('java','java.lang.StringBuffer').init("") />
        <cfloop from="1" to="#ArrayLen(_data)#" index="i">
            <cfset tempVal = encode( _data[i], arguments.queryFormat, arguments.queryKeyCase, arguments.stringNumbers, arguments.formatDates, arguments.columnListFormat ) />
            <cfif dJSONString.toString() EQ "">
                <cfset dJSONString.append(tempVal) />
            <cfelse>
                <cfset dJSONString.append("," & tempVal) />
            </cfif>
        </cfloop>
        
        <cfreturn "[" & dJSONString.toString() & "]" />
    
    <!--- STRUCT --->
    <cfelseif IsStruct(_data)>
        <cfset dJSONString = createObject('java','java.lang.StringBuffer').init("") />
        <cfset arKeys = StructKeyArray(_data) />
        <cfloop from="1" to="#ArrayLen(arKeys)#" index="i">
            <cfset tempVal = encode( _data[ arKeys[i] ], arguments.queryFormat, arguments.queryKeyCase, arguments.stringNumbers, arguments.formatDates, arguments.columnListFormat ) />
            <cfif dJSONString.toString() EQ "">
                <cfset dJSONString.append('"' & arKeys[i] & '":' & tempVal) />
            <cfelse>
                <cfset dJSONString.append("," & '"' & arKeys[i] & '":' & tempVal) />
            </cfif>
        </cfloop>
        
        <cfreturn "{" & dJSONString.toString() & "}" />
    
    <!--- QUERY --->
    <cfelseif IsQuery(_data)>
        <cfset dJSONString = createObject('java','java.lang.StringBuffer').init("") />
        
        <!--- Add query meta data --->
        <cfif arguments.queryKeyCase EQ "lower">
            <cfset recordcountKey = "recordcount" />
            <cfset columnlistKey = "columnlist" />
            <cfset columnlist = LCase(_data.columnlist) />
            <cfset dataKey = "data" />
        <cfelse>
            <cfset recordcountKey = "RECORDCOUNT" />
            <cfset columnlistKey = "COLUMNLIST" />
            <cfset columnlist = _data.columnlist />
            <cfset dataKey = "data" />
        </cfif>
        
        <cfset dJSONString.append('"#recordcountKey#":' & _data.recordcount) />
        <cfif arguments.columnListFormat EQ "array">
            <cfset columnlist = "[" & ListQualify(columnlist, '"') & "]" />
            <cfset dJSONString.append(',"#columnlistKey#":' & columnlist) />
        <cfelse>
            <cfset dJSONString.append(',"#columnlistKey#":"' & columnlist & '"') />
        </cfif>
        <cfset dJSONString.append(',"#dataKey#":') />
        
        <!--- Make query a structure of arrays --->
        <cfif arguments.queryFormat EQ "query">
            <cfset dJSONString.append("{") />
            <cfset colPos = 1 />
            
            <cfloop list="#_data.columnlist#" delimiters="," index="column">
                <cfif colPos GT 1>
                    <cfset dJSONString.append(",") />
                </cfif>
                <cfif arguments.queryKeyCase EQ "lower">
                    <cfset column = LCase(column) />
                </cfif>
                <cfset dJSONString.append('"' & column & '":[') />
                
                <cfloop from="1" to="#_data.recordcount#" index="i">
                    <!--- Get cell value; recurse to get proper format depending on string/number/boolean data type --->
                    <cfset tempVal = encode( _data[column][i], arguments.queryFormat, arguments.queryKeyCase, arguments.stringNumbers, arguments.formatDates, arguments.columnListFormat ) />
                    
                    <cfif i GT 1>
                        <cfset dJSONString.append(",") />
                    </cfif>
                    <cfset dJSONString.append(tempVal) />
                </cfloop>
                
                <cfset dJSONString.append("]") />
                
                <cfset colPos = colPos + 1 />
            </cfloop>
            <cfset dJSONString.append("}") />
        <!--- Make query an array of structures --->
        <cfelse>
            <cfset dJSONString.append("[") />
            <cfloop query="_data">
                <cfif CurrentRow GT 1>
                    <cfset dJSONString.append(",") />
                </cfif>
                <cfset dJSONString.append("{") />
                <cfset colPos = 1 />
                <cfloop list="#columnlist#" delimiters="," index="column">
                    <cfset tempVal = encode( _data[column][CurrentRow], arguments.queryFormat, arguments.queryKeyCase, arguments.stringNumbers, arguments.formatDates, arguments.columnListFormat ) />
                    
                    <cfif colPos GT 1>
                        <cfset dJSONString.append(",") />
                    </cfif>
                    
                    <cfif arguments.queryKeyCase EQ "lower">
                        <cfset column = LCase(column) />
                    </cfif>
                    <cfset dJSONString.append('"' & column & '":' & tempVal) />
                    
                    <cfset colPos = colPos + 1 />
                </cfloop>
                <cfset dJSONString.append("}") />
            </cfloop>
            <cfset dJSONString.append("]") />
        </cfif>
        
        <!--- Wrap all query data into an object --->
        <cfreturn "{" & dJSONString.toString() & "}" />
    
    <!--- UNKNOWN OBJECT TYPE --->
    <cfelse>
        <cfreturn '"' & "unknown-obj" & '"' />
    </cfif>
</cffunction>

<cffunction 
    name       ="validate"
    access     ="remote" 
    output     ="yes" 
    returntype ="boolean"
    hint       ="I validate a JSON document against a JSON schema">

    <cfargument 
        name     ="doc" 
        type     ="string"
        required ="No"/>

    <cfargument 
        name     ="schema" 
        type     ="string" 
        required ="No"/>

    <cfargument 
        name     ="errorVar" 
        type     ="string" 
        required ="No" 
        default  ="jsonSchemaErrors"/>

    <cfargument 
        name     ="stopOnError" 
        type     ="boolean" 
        required ="No" 
        default  =true/>
    
    <!--- These arguments are for internal use only --->
    <cfargument 
        name     ="_doc" 
        type     ="any" 
        required ="No"/>

    <cfargument 
        name     ="_schema" 
        type     ="any" 
        required ="No" />

    <cfargument 
        name     ="_item" 
        type     ="string" 
        required ="No" 
        default  ="root"/>
    
    <cfset var schemaRules = "" />
    <cfset var jsonDoc = "" />
    <cfset var i = 0 />
    <cfset var key = "" />
    <cfset var isValid = true />
    <cfset var msg = "" />
    
    <cfif StructKeyExists(arguments, "doc")>
        <cfif FileExists(arguments.doc)>
            <cffile action="READ" file="#arguments.doc#" variable="arguments.doc" />
        </cfif>
        
        <cfif FileExists(arguments.schema)>
            <cffile action="READ" file="#arguments.schema#" variable="arguments.schema" />
        </cfif>
        
        <cfset jsonDoc = decode(arguments.doc) />
        <cfset schemaRules = decode(arguments.schema) />
    
        <cfset request[arguments.errorVar] = ArrayNew(1) />
    <cfelseif StructKeyExists(arguments, "_doc")>
        <cfset jsonDoc = arguments._doc />
        <cfset schemaRules = arguments._schema />
    </cfif>
    
    <!--- See if the document matches the rules from the schema --->
    <cfif schemaRules.type EQ "struct">
        <cfif NOT IsStruct(jsonDoc)>
            <cfset ArrayPrepend(request[arguments.errorVar], "#arguments._item# should be a struct") />
            <cfif arguments.stopOnError>
                <cfreturn false />
            </cfif>
        <cfelse>
            <!--- If specific keys are set to be required, check if they exist --->
            <cfif StructKeyExists(schemaRules, "keys")>
                <cfloop from="1" to="#ArrayLen(schemaRules.keys)#" index="i">
                    <cfif NOT StructKeyExists(jsonDoc, schemaRules.keys[i])>
                        <cfset ArrayPrepend(request[arguments.errorVar], "#arguments._item# should have a key named #schemaRules.keys[i]#") />
                        <cfif arguments.stopOnError>
                            <cfreturn false />
                        </cfif>
                    </cfif>
                </cfloop>
            </cfif>
            
            <!--- Loop over all the keys for the structure and see if they are valid (if items key is specified) by recursing the validate function --->
            <cfif StructKeyExists(schemaRules, "items")>
                <cfloop collection="#jsonDoc#" item="key">
                    <cfif StructKeyExists(schemaRules.items, key)>
                        <cfset isValid = validate(_doc=jsonDoc[key], _schema=schemaRules.items[key], _item="#arguments._item#['#key#']", errorVar=arguments.errorVar, stopOnError=arguments.stopOnError) />
                        <cfif arguments.stopOnError AND NOT isValid>
                            <cfreturn false />
                        </cfif>
                    </cfif>
                </cfloop>
            </cfif>
        </cfif>
    <cfelseif schemaRules.type EQ "array">
        <cfif NOT IsArray(jsonDoc)>
            <cfset ArrayPrepend(request[arguments.errorVar], "#arguments._item# should be an array") />
            <cfif arguments.stopOnError>
                <cfreturn false />
            </cfif>
        <cfelse>
            <cfparam name="schemaRules.minlength" default="0" />
            <cfparam name="schemaRules.maxlength" default="9999999999" />
            
            <!--- If there are length requirements for the array make sure they are valid --->
            <cfif ArrayLen(jsonDoc) LT schemaRules.minlength>
                <cfset ArrayPrepend(request[arguments.errorVar], "#arguments._item# is an array that should have at least #schemaRules.minlength# elements") />
                <cfif arguments.stopOnError>
                    <cfreturn false />
                </cfif>
            <cfelseif ArrayLen(jsonDoc) GT schemaRules.maxlength>
                <cfset ArrayPrepend(request[arguments.errorVar], "#arguments._item# is an array that should have at the most #schemaRules.maxlength# elements") />
                <cfif arguments.stopOnError>
                    <cfreturn false />
                </cfif>
            </cfif>
            
            <!--- Loop over the array elements and if there are rules for the array items recurse to enforce them --->
            <cfif StructKeyExists(schemaRules, "items")>
                <cfloop from="1" to="#ArrayLen(jsonDoc)#" index="i">
                    <cfset isValid = validate(_doc=jsonDoc[i], _schema=schemaRules.items, _item="#arguments._item#[#i#]", errorVar=arguments.errorVar, stopOnError=arguments.stopOnError) />
                    <cfif arguments.stopOnError AND NOT isValid>
                        <cfreturn false />
                    </cfif>
                </cfloop>
            </cfif>
        </cfif>
    <cfelseif schemaRules.type EQ "number">
        <cfif NOT IsNumeric(jsonDoc)>
            <cfset ArrayPrepend(request[arguments.errorVar], "#arguments._item# should be numeric") />
            <cfif arguments.stopOnError>
                <cfreturn false />
            </cfif>
        <cfelseif StructKeyExists(schemaRules, "min") AND jsonDoc LT schemaRules.min>
            <cfset ArrayPrepend(request[arguments.errorVar], "#arguments._item# cannot be a number less than #schemaRules.min#") />
            <cfif arguments.stopOnError>
                <cfreturn false />
            </cfif>
        <cfelseif StructKeyExists(schemaRules, "max") AND jsonDoc GT schemaRules.max>
            <cfset ArrayPrepend(request[arguments.errorVar], "#arguments._item# cannot be a number greater than #schemaRules.max#") />
            <cfif arguments.stopOnError>
                <cfreturn false />
            </cfif>
        </cfif>
    <cfelseif schemaRules.type EQ "boolean" AND ( NOT IsBoolean(jsonDoc) OR ListFindNoCase("Yes,No", jsonDoc) OR IsNumeric(jsonDoc) )>
        <cfset ArrayPrepend(request[arguments.errorVar], "#arguments._item# should be a boolean") />
        <cfif arguments.stopOnError>
            <cfreturn false />
        </cfif>
    <cfelseif schemaRules.type EQ "date">
        <cfif NOT IsSimpleValue(jsonDoc) OR NOT IsDate(jsonDoc)
                OR ( StructKeyExists(schemaRules, "mask") AND CompareNoCase( jsonDoc, DateFormat(jsonDoc, schemaRules.mask) ) NEQ 0 )>
            <cfif StructKeyExists(schemaRules, "mask")>
                <cfset msg = " in #schemaRules.mask# format" />
            </cfif>
            <cfset ArrayPrepend(request[arguments.errorVar], "#arguments._item# should be a date#msg#") />
            <cfif arguments.stopOnError>
                <cfreturn false />
            </cfif>
        </cfif>
    <cfelseif schemaRules.type EQ "string">
        <cfif NOT IsSimpleValue(jsonDoc)>
            <cfset ArrayPrepend(request[arguments.errorVar], "#arguments._item# should be a string") />
            <cfif arguments.stopOnError>
                <cfreturn false />
            </cfif>
        <cfelseif StructKeyExists(schemaRules, "minlength") AND Len(jsonDoc) LT schemaRules.minlength>
            <cfset ArrayPrepend(request[arguments.errorVar], "#arguments._item# should have a minimum length of #schemaRules.minlength#") />
            <cfif arguments.stopOnError>
                <cfreturn false />
            </cfif>
        <cfelseif StructKeyExists(schemaRules, "maxlength") AND Len(jsonDoc) GT schemaRules.maxlength>
            <cfset ArrayPrepend(request[arguments.errorVar], "#arguments._item# should have a maximum length of #schemaRules.maxlength#") />
            <cfif arguments.stopOnError>
                <cfreturn false />
            </cfif>
        </cfif>
    </cfif>
    
    <cfif ArrayLen(request[arguments.errorVar])>
        <cfreturn false />
    <cfelse>
        <cfreturn true />
    </cfif>
 </cffunction>

 <cffunction 
    name         ="getSqlType" 
    access       ="private" 
    output       ="false" 
    returntype   ="String"
    >

    <cfargument 
        name     ="type"    
        type     ="string"
        required ="false"
        default  =""    
        hint     ="Tipo do campo">

    <cfscript>

        switch(arguments.type){
            case 'int':
                'cf_sql_integer';
                break;

            case 'string':
                'cf_sql_varchar';
                break;

            case 'varchar':
                'cf_sql_varchar';
                break;
        
            default:
                'cf_sql_varchar';
                break;
        }

    </cfscript>

</cffunction>

<!--- http://www.bennadel.com/blog/149-ask-ben-converting-a-query-to-a-struct.htm --->
<cffunction name="QueryToStruct" access="public" returntype="any" output="false"
    hint="Converts an entire query or the given record to a struct. This might return a structure (single record) or an array of structures.">

    <!--- Define arguments. --->
    <cfargument name="Query" type="query" required="true" />
    <cfargument name="Row" type="numeric" required="false" default="0" />

    <cfscript>
        // Define the local scope.
        var LOCAL = StructNew();
        // Determine the indexes that we will need to loop over.
        // To do so, check to see if we are working with a given row,
        // or the whole record set.
        if (ARGUMENTS.Row){
            // We are only looping over one row.
            LOCAL.FromIndex = ARGUMENTS.Row;
            LOCAL.ToIndex = ARGUMENTS.Row;
        } else {
            // We are looping over the entire query.
            LOCAL.FromIndex = 1;
            LOCAL.ToIndex = ARGUMENTS.Query.RecordCount;
        }
        // Get the list of columns as an array and the column count.
        LOCAL.Columns = ListToArray( ARGUMENTS.Query.ColumnList );
        LOCAL.ColumnCount = ArrayLen( LOCAL.Columns );
        // Create an array to keep all the objects.
        LOCAL.DataArray = ArrayNew( 1 );
        // Loop over the rows to create a structure for each row.
        for (LOCAL.RowIndex = LOCAL.FromIndex ; LOCAL.RowIndex LTE LOCAL.ToIndex ; LOCAL.RowIndex = (LOCAL.RowIndex + 1)){
            // Create a new structure for this row.
            ArrayAppend( LOCAL.DataArray, StructNew() );
            // Get the index of the current data array object.
            LOCAL.DataArrayIndex = ArrayLen( LOCAL.DataArray );
            // Loop over the columns to set the structure values.
            for (LOCAL.ColumnIndex = 1 ; LOCAL.ColumnIndex LTE LOCAL.ColumnCount ; LOCAL.ColumnIndex = (LOCAL.ColumnIndex + 1)){
                // Get the column value.
                LOCAL.ColumnName = LOCAL.Columns[ LOCAL.ColumnIndex ];
                // Set column value into the structure.
                LOCAL.DataArray[ LOCAL.DataArrayIndex ][ LOCAL.ColumnName ] = ARGUMENTS.Query[ LOCAL.ColumnName ][ LOCAL.RowIndex ];
            }
        }
        // At this point, we have an array of structure objects that
        // represent the rows in the query over the indexes that we
        // wanted to convert. If we did not want to convert a specific
        // record, return the array. If we wanted to convert a single
        // row, then return the just that STRUCTURE, not the array.
        if (ARGUMENTS.Row){
            // Return the first array item.
            return( LOCAL.DataArray[ 1 ] );
        } else {
            // Return the entire array.
            return( LOCAL.DataArray );
        }
    </cfscript>
</cffunction>