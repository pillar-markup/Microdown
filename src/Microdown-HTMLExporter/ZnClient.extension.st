Extension { #name : #ZnClient }

{ #category : #'*Microdown-HTMLExporter' }
ZnClient >> requestSegments [

	^ self requestUri segments
]

{ #category : #'*Microdown-HTMLExporter' }
ZnClient >> requestUri [

	^ self request uri
]

{ #category : #'*Microdown-HTMLExporter' }
ZnClient >> requestedResource [

	^ self requestSegments last
]
