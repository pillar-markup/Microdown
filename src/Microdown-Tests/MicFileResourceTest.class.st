"
These tests will fail if MicHTTPResourceTest fails. I read the files from the git stores using the http based methods and stores them in local files for test of the file access.

"
Class {
	#name : #MicFileResourceTest,
	#superclass : #TestCase,
	#instVars : [
		'filesystem',
		'emptyResolver',
		'fullResolver'
	],
	#category : #'Microdown-Tests-Resources'
}

{ #category : #private }
MicFileResourceTest >> exampleMicFileResource [

	| file |
	
	file := self exampleReadmeFile.
	^ MicFileResource on: file reference: (filesystem resolvePath: file path)
]

{ #category : #private }
MicFileResourceTest >> examplePNGByteArray [

	^ #[137 80 78 71 13 10 26 10 0 0 0 13 73 72 68 82 0 0 0 200 0 0 0 90 4 3 0 0 0 15
216 4 229 0 0 0 27 80 76 84 69 204 204 204 150 150 150 197 197 197 190 190 190
183 183 183 156 156 156 177 177 177 170 170 170 163 163 163 19 233 37 248 0 0 0
9 112 72 89 115 0 0 14 196 0 0 14 196 1 149 43 14 27 0 0 1 69 73 68 65 84 104
129 237 211 177 79 194 64 20 199 241 119 109 161 140 244 90 140 227 93 33 113
165 198 238 101 176 58 34 185 18 199 50 52 58 214 193 176 2 49 145 63 219 119
103 48 14 198 165 37 209 228 247 73 94 30 44 253 230 122 64 4 0 0 0 0 0 0 0 240
119 9 245 237 139 236 247 217 95 143 251 239 17 17 81 99 72 231 107 142 12 171
226 157 70 45 47 142 120 113 85 123 241 254 64 225 99 214 53 226 39 65 178 153
235 67 94 8 245 90 198 13 137 57 47 27 185 156 26 111 114 125 164 166 124 232
124 20 57 40 194 86 23 193 78 164 49 61 105 149 121 188 108 36 161 123 254 152
145 161 77 247 136 80 254 82 243 136 233 146 242 65 177 245 121 217 136 164 156
71 243 116 126 93 36 53 121 99 77 254 88 204 162 40 10 91 19 240 178 145 49 101
60 218 78 143 39 153 173 210 212 95 201 128 215 233 36 54 208 203 73 62 239 36
108 197 84 210 29 93 236 124 187 220 157 108 93 164 143 59 89 187 95 151 217 204
133 58 150 107 218 215 100 151 28 165 147 50 118 145 69 25 117 142 188 184 255
201 173 33 161 174 170 154 22 138 236 146 34 77 170 194 69 134 213 162 115 196
249 225 106 57 112 146 159 63 242 70 207 231 143 52 55 166 159 200 111 70 147
250 252 17 0 0 0 0 0 128 126 124 0 210 193 48 179 58 123 246 137 0 0 0 0 73 69
78 68 174 66 96 130]
]

{ #category : #private }
MicFileResourceTest >> examplePNGFile [
	" Answer a <Form> for testing purposes "

	^ PNGReadWriter formFromStream: self examplePNGFileContents

]

{ #category : #private }
MicFileResourceTest >> examplePNGFileContents [

	^ self examplePNGByteArray readStream
]

{ #category : #private }
MicFileResourceTest >> exampleReadmeFile [
	" Answer a <FileReference> on a memory file system for testing purposes "

	^ (filesystem workingDirectory / 'example.md')
		writeStreamDo: [ :stream | stream nextPutAll: self exampleReadmeFileContents ];
		yourself
]

{ #category : #private }
MicFileResourceTest >> exampleReadmeFileContents [
	" Answer a <String> for file resource testing purposes "

	^ '# Test documents
This directory and its subdirectories contain documents whose sole purpose is to test access to http based documents, and the resolvers for relative links and images.

This is a same level image

![](toplevel.png)

This is a sub level image

![](images/image1.png)

Link to a document in the same folder:

[Link same folder](other.md)

Link to a document in subfolder:

[Link to subfolder](subfolder/subfolderdocument.md)
'
]

{ #category : #running }
MicFileResourceTest >> setUp [
	| readme image file |
	super setUp.
	emptyResolver := MicUrlResolver new.
	filesystem := FileSystem memory.
	readme := self exampleReadmeFile contents. "(ZnEasy get: (MicHTTPResourceTest githubTestData uri + 'readme.md')) contents."
	image := self examplePNGFile. "ZnEasy getPng: (MicHTTPResourceTest githubTestData uri + 'toplevel.png')."

	fullResolver := MicUrlResolver new
		currentWorkingDirectory: filesystem workingDirectory;
		yourself.
	
	file := filesystem workingDirectory / 'readme.md'.
	file writeStreamDo: [ :stream | stream nextPutAll: readme].
	
	file := filesystem workingDirectory / 'toplevel.png'.
	PNGReadWriter putForm: image onStream: file binaryWriteStream.
	
]

{ #category : #tests }
MicFileResourceTest >> testContents [

	| micFileResource |
	
	micFileResource := self exampleMicFileResource.
	self assert: micFileResource contents equals: self exampleReadmeFileContents
]

{ #category : #tests }
MicFileResourceTest >> testFileReference [

	| micFileResource |
	micFileResource := self exampleMicFileResource.
	self 
		assert: (micFileResource fileReference isKindOf: FileReference)
		description: 'It asserts that the file reference of a file resource it is actually a FileReference'
]

{ #category : #tests }
MicFileResourceTest >> testLoadImage [

	| ref image |
	ref := MicResourceReference fromUri: 'file:///toplevel.png'.
	image := (ref resolveResourceIn: fullResolver) asForm.
	self assert: image notNil.
	self assert: image height equals: 90.
	self assert: image width equals: 200
]

{ #category : #tests }
MicFileResourceTest >> testLoadMicrodown [
	| uri ref doc resolvedReference |
	uri := 'file:///readme.md'.
	ref := MicResourceReference  fromUri: uri.
	resolvedReference := ref resolveResourceIn: fullResolver.
	doc := resolvedReference parseMicrodown.
	self assert: doc children first class equals: MicHeaderBlock.
	self assert: doc children first text equals: 'Test documents' 
	
]

{ #category : #tests }
MicFileResourceTest >> testLoadNotCorrectImage [

	| ref |
	ref := MicResourceReference fromUri: 'file:///readme.md'.
	
	self
		should: [(ref resolveResourceIn: fullResolver) asForm]
		raise: UnrecognizedImageFormatError
]

{ #category : #tests }
MicFileResourceTest >> testLoadNotCorrectMicrodown [

	| ref |
	ref := MicResourceReference fromUri: 'file:///toplevel.png'.
	
	self
		should: [(ref resolveResourceIn: fullResolver) parseMicrodown]
		raise: ZnInvalidUTF8
]

{ #category : #tests }
MicFileResourceTest >> testLoadNotFoundImage [

	| ref image |
	ref := MicResourceReference fromUri: 'file:///readme.md'.
	image := (ref resolveResourceIn: emptyResolver) asForm.

	self assert: image isNil
]

{ #category : #tests }
MicFileResourceTest >> testLoadNotFoundMicrodown [
	| uri ref resolvedReference |
	uri := 'file:///readme.md'.
	ref := MicResourceReference  fromUri: uri.
	resolvedReference := ref resolveResourceIn: emptyResolver.
	
	[
		resolvedReference parseMicrodown.
		self fail
	] on: Error do: [ :e |
		self assert: e messageText equals: 'Microdown file not found' ]
]
