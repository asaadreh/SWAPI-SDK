# SWAPI-SDK
SDK for Star Wars API


## Discussion and Working

Initially I was thinking about the SDK as a type of API Manager. The way I usually structure my API Manager is by making a protocol of Endpoint and then making an enum which conforms to that endpoint with all the endpoints as cases. The endpoint is then passed into a request function which makes the API Call. However, Enums are rather limiting in that whenever a change has to be made, the endpoint has to be changed. But on the other hand it also makes making api calls very convenient. 

Another approach might be to pass in the requirements as a dictionary. For instance passing in the literals “people” and “eye color”. This would introduce a lot of error-handling but it would make the API more flexible and would require much less maintenance. 

Since this was supposed to be an SDK, I went with the latter approach. The SDK has two public functions :

func getOneWithId(resource: String, withId id: Int?, requiredAttributes attributes: [String], completion: @escaping APIResult)

func getAll(resource: String, requiredAttributes attributes: [String], completion: @escaping APIResultAll)


The nomenclature can surely do better but the idea is that the model (film, people etc) is passed in as "resource" and the required attributes are passed in as a String array in "requiredAttributes". The result is returned back in a closure

## Known Issues and ToDos

The plan was to add another api which would limit the response to required number of objects. Lets say 5 people with required attributes would be returned

The API would then be wrapped in a Swift Package and then that could be imported in any project.
