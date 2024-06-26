Class {
	#name : 'MicFileTestResources',
	#superclass : 'Object',
	#instVars : [
		'micSummarizer'
	],
	#category : 'Microdown-Blog-Tests',
	#package : 'Microdown-Blog-Tests'
}

{ #category : 'as yet unclassified' }
MicFileTestResources >> dumperInput1 [

	| root |
	root := Microdown parse:
		        '# [A Cool Story](' , '' , '/anExample1.html' , '' , ')'.
	root children add: (Microdown parse: '2019/01/09') children first.
	root children add: (Microdown parse:
			 'Pharo is cool but this is a superlong paragraph Simple powerful language: No constructors, no...')
			children first.

	^ root
]

{ #category : 'as yet unclassified' }
MicFileTestResources >> dumperInput2 [

	| root |
	root := Microdown parse:
		        '# [Pharo is cool](' , '' , '/anExample2.html' , '' , ')'.
	root children add:
		(Microdown parse: '2019/01/22') children first.
	root children add: (Microdown parse:
			 'If you are either a beginner or an expert in object-oriented programming, this MOOC will...')
			children first.

	^ root
]

{ #category : 'as yet unclassified' }
MicFileTestResources >> dumperInput3 [

	| root |
	root := Microdown parse:
		        '# [Mooc Pharo](' , '' , '/anExample3.html' , '' , ')'.
	root children add:
		(Microdown parse: '2018/01/29') children first.
	root children add: (Microdown parse:
			 'Welcome to the Pharo Mooc (a set of videos, exercises, challenges, and miniprojects).')
			children first.

	^ root
]

{ #category : 'as yet unclassified' }
MicFileTestResources >> fileSystem [

	^ FileSystem memory
]

{ #category : 'as yet unclassified' }
MicFileTestResources >> generateFilesystemExample1 [

	| file |
	file := self workingDirectory / 'anExample1.md'.
	file writeStreamDo: [ :stream |
		stream nextPutAll: '{
    "date" : "2019/01/09"
}
# A Cool Story

Pharo is cool but _this is_ a superlong _paragraph_ Simple powerful language: No constructors, no types declaration, no interfaces, no primitive types. Yet a powerful and elegant language with a full syntax fitting in one postcard! Pharo is objects and messages all the way down. _Live_, immersive environment: Immediate feedback at any moment of your development: _Developing_, testing, debugging. Even in production environments, you will never be stuck in compiling and deploying steps again!
    

Amazing debugging experience: The Pharo environment includes a debugger unlike anything you''ve seen before. It allows you to step through code, restart the execution of methods, create methods on the fly, and much more!
' ].

	^ file asFileReference
]

{ #category : 'as yet unclassified' }
MicFileTestResources >> generateFilesystemExample2 [

	| file |
	file := self workingDirectory / 'anExample2.md'.
	file writeStreamDo: [ :stream |
		stream nextPutAll: '{
    "date" : "2019/01/22"
}
# Pharo is cool

If you are either a beginner or an expert in object-oriented programming, _this MOOC_ will change the way you program with objects: come and learn or rediscover _object-oriented programming_ with Pharo!

Pharo is a pure _object-oriented programming language_ in the tradition of Smalltalk. It offers a unique developing experience in constant interaction with live objects. Pharo is elegant, fun to use and very powerful. It is very easy to learn and enables to understand advanced concept in a natural way. When programming in Pharo, you are immersed in a world of live objects. You have immediate feedback at any moment of your development on objects representing web applications, code itself, graphics, network. More…
' ].

	^ file
]

{ #category : 'as yet unclassified' }
MicFileTestResources >> generateFilesystemExample3 [

	| file |
	file := self workingDirectory / 'anExample3.md'.
	file writeStreamDo: [ :stream |
		stream nextPutAll: '{
    "date" : "2018/01/29"
}
# Mooc Pharo

Welcome to the Pharo Mooc (a set of videos, exercises, challenges, and miniprojects). 

The Pharo Mooc is fully dubbed in french and english. It comes with subtitles in Japanese, english, french and spanish. This web site contains all the material of this Mooc in free access.

In addition, in average every 18 months the Mooc is proposed and run on the France Université Numérique platform (Even if the platform is french the mooc is run in both languages). 

When you participate to the mooc you get access to the quizz and the credit validation. 
' ].

	^ file
]

{ #category : 'fixture' }
MicFileTestResources >> generateFilesystemExample3WithBrokenDate [

	| file |
	file := self workingDirectory / 'anExample3.md'.
	file writeStreamDo: [ :stream |
		stream nextPutAll: '{
    "date" : "20219190199191817161"
}
# Mooc Pharo

Welcome to the Pharo Mooc (a set of videos, exercises, challenges, and miniprojects). 

The Pharo Mooc is fully dubbed in french and english. It comes with subtitles in Japanese, english, french and spanish. This web site contains all the material of this Mooc in free access.

In addition, in average every 18 months the Mooc is proposed and run on the France Université Numérique platform (Even if the platform is french the mooc is run in both languages). 

When you participate to the mooc you get access to the quizz and the credit validation. 
' ].

	^ file
]

{ #category : 'fixture' }
MicFileTestResources >> generateFilesystemExampleWithoutMetadata1 [

	| file |
	file := self workingDirectory / 'anExample1.md'.
	file writeStreamDo: [ :stream |
		stream nextPutAll: '# A Cool Story

Pharo is cool but _this is_ a superlong _paragraph_ Simple powerful language: No constructors, no types declaration, no interfaces, no primitive types. Yet a powerful and elegant language with a full syntax fitting in one postcard! Pharo is objects and messages all the way down. _Live_, immersive environment: Immediate feedback at any moment of your development: _Developing_, testing, debugging. Even in production environments, you will never be stuck in compiling and deploying steps again!
    

Amazing debugging experience: The Pharo environment includes a debugger unlike anything you''ve seen before. It allows you to step through code, restart the execution of methods, create methods on the fly, and much more!
' ].

	^ file asFileReference
]

{ #category : 'fixture' }
MicFileTestResources >> generateFilesystemExampleWithoutMetadata2 [

	| file |
	file := self workingDirectory / 'anExample2.md'.
	file writeStreamDo: [ :stream |
		stream nextPutAll: '{# Pharo is cool

If you are either a beginner or an expert in object-oriented programming, _this MOOC_ will change the way you program with objects: come and learn or rediscover _object-oriented programming_ with Pharo!

Pharo is a pure _object-oriented programming language_ in the tradition of Smalltalk. It offers a unique developing experience in constant interaction with live objects. Pharo is elegant, fun to use and very powerful. It is very easy to learn and enables to understand advanced concept in a natural way. When programming in Pharo, you are immersed in a world of live objects. You have immediate feedback at any moment of your development on objects representing web applications, code itself, graphics, network. More…
' ].

	^ file
]

{ #category : 'fixture' }
MicFileTestResources >> generateFilesystemExampleWithoutMetadata3 [

	| file |
	file := self workingDirectory / 'anExample3.md'.
	file writeStreamDo: [ :stream |
		stream nextPutAll: '# Mooc Pharo

Welcome to the Pharo Mooc (a set of videos, exercises, challenges, and miniprojects). 

The Pharo Mooc is fully dubbed in french and english. It comes with subtitles in Japanese, english, french and spanish. This web site contains all the material of this Mooc in free access.

In addition, in average every 18 months the Mooc is proposed and run on the France Université Numérique platform (Even if the platform is french the mooc is run in both languages). 

When you participate to the mooc you get access to the quizz and the credit validation. 
' ].

	^ file
]

{ #category : 'as yet unclassified' }
MicFileTestResources >> workingDirectory [

	^ self fileSystem workingDirectory
]
