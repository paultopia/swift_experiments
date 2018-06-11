import PerfectHTTP
import PerfectHTTPServer


var saying = ToSay()

func handler(request: HTTPRequest, response: HTTPResponse) {
	  response.setHeader(.contentType, value: "text/html")
	  response.appendBody(string: "<html><title>\(saying.text)</title><body>\(saying.text)</body></html>")
	  response.completed()
}

let confData = [
	"servers": [
		[
			"name":"localhost",
			"port":8181,
			"routes":[
				["method":"get", "uri":"/", "handler":handler],
				["method":"get", "uri":"/**", "handler":PerfectHTTPServer.HTTPHandler.staticFiles,
				 "documentRoot":"./webroot",
				 "allowResponseFilters":true]
			],
			"filters":[
				[
				  "type":"response",
				  "priority":"high",
				  "name":PerfectHTTPServer.HTTPFilter.contentCompression,
				]
			]
		]
	]
]

if CommandLine.arguments.count == 2 {
    saying.text = CommandLine.arguments[1]
}

do {
	  try HTTPServer.launch(configurationData: confData)
} catch {
	  fatalError("\(error)") 
}

