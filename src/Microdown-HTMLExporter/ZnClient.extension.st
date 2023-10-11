Extension { #name : 'ZnClient' }

{ #category : '*Microdown-HTMLExporter' }
ZnClient >> requestSegments [
	"Answer a <Collection> with the receiver's parts (those separated by /)"

	^ self requestUri segments
]

{ #category : '*Microdown-HTMLExporter' }
ZnClient >> requestUri [

	^ self request uri
]

{ #category : '*Microdown-HTMLExporter' }
ZnClient >> requestedResource [
	"Answer a <String> with the name of resource (file or directory) requested"
	
	^ self requestSegments last
]
