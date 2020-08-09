Extension { #name : #PRRichTextComposer }

{ #category : #'*Microdown-RichTextComposer' }
PRRichTextComposer class >> exampleMicrodown1 [
	<example>
	(self microdownAsRichText: '### First section
and this is just *first* line 
1. Line 1 More here More here ==More here More here== More here More here More here More here More here More here
   - Kasper tries the strange thing Kasper tries the strange thingKasper tries the strange thingKasper tries the strange thingKasper tries the strange thingKasper tries the strange thingKasper tries the strange thing
   - And one more __silly__ thingie
1. Line 2
   - Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla
   - Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla
1. Line 3') inspect
]

{ #category : #'*Microdown-RichTextComposer' }
PRRichTextComposer class >> examplePillar10 [
	<example>
	(self asText:
					'
[[[language=PharoMethod
1 + 2 * 3
]]]
') inspect
]

{ #category : #'*Microdown-RichTextComposer' }
PRRichTextComposer class >> examplePillar2 [
	<example>
	(self asText:
					'!!!Description lists
this is just ""first"" line
# Here is frist enumaration
#;blue
#:color of the sky
#:and my true love''s eyes
#;red
#:color of the fire') inspect
]

{ #category : #'*Microdown-RichTextComposer' }
PRRichTextComposer class >> examplePillar3 [
	<example>
	(self asText:
					'!!!Code sections
this is just ""first"" line
[[[
Metacello new
   baseline: ''PillarRichTextExporter'';
   repository: ''github://kasperosterbye/PillarRichTextRender'';
   load.
]]]') inspect
]

{ #category : #'*Microdown-RichTextComposer' }
PRRichTextComposer class >> examplePillar4 [
	<example>
	(self asText:
					'!!!Annotations
this is just ""first"" line
@@todo remember to do annotations
and this is the second line') inspect
]

{ #category : #'*Microdown-RichTextComposer' }
PRRichTextComposer class >> examplePillar5 [
	<example>
	(self asText:
					'!!!Links
this is just ""first"" line

*Pharo>http://pharo.org/*

*String>browse://String*

*String»trim>browse://String>>#trim*

and this is the second line') inspect
]

{ #category : #'*Microdown-RichTextComposer' }
PRRichTextComposer class >> examplePillar6 [
	<example>
	(self asText:
					'!!!Figures
this is just ""first"" line

+Pharologo>https://files.pharo.org/media/logo/logo.png+

and this is the second line') inspect
]

{ #category : #'*Microdown-RichTextComposer' }
PRRichTextComposer class >> examplePillar7 [
	<example>
	(self asText:
					'!First section

# ==Point== should open a class browser on Point.
# ==Point class== should open a class browser on Point.
# ==Point >> setX:setY:== should open a browser on the correspoding method.
# ==Pillar\-ExporterRichText== should open a browser on the package.
') inspect
]

{ #category : #'*Microdown-RichTextComposer' }
PRRichTextComposer class >> examplePillar8 [
	<example>
	(self asText:
					'
[[[language=PharoExpression
1 + 2 * 3  
]]]
') inspect
]

{ #category : #'*Microdown-RichTextComposer' }
PRRichTextComposer class >> examplePillar9 [
	<example>
	(self asText:
					'
[[[language=PharoMethod
foo: arg
	^ arg + self
]]]
') inspect
]

{ #category : #'*Microdown-RichTextComposer' }
PRRichTextComposer class >> examplePillarLatexMath [
	<example>
	(PRRichTextComposer  asText:
'!!!Latex mathematics 
It is possible to render latex math:
[[[language=latexMath
V_i = C_0 - C_3
\frac{C_1\cos(\theta_i+C_3)}{C_4+C_1\cos(\theta_i+C_2)}
]]]
Cool eh?
') inspect
]

{ #category : #'*Microdown-RichTextComposer' }
PRRichTextComposer class >> microdown [
	^ MicroDownParser 
	
]

{ #category : #'*Microdown-RichTextComposer' }
PRRichTextComposer class >> microdownAsDocument: aString [
	^ (self microdown parse: aString ) asPillar
]

{ #category : #'*Microdown-RichTextComposer' }
PRRichTextComposer class >> microdownAsRichText: aString [
	^ (self new start: (self microdown parse: aString ) asPillar)
]

{ #category : #'*Microdown-RichTextComposer' }
PRRichTextComposer class >> renderComment: aString of: aClassOrPackage [ 
	"Return aString as part of the templated class comment, when rendering is on.
	Else aString."
	
	| builder |
	builder := MicroDownParser builder.
	aClassOrPackage buildMicroDownUsing: builder withComment: aString.
	self flag: #fixMe.
	"I do not like the asText: the interaction between parser, richtext composer should be 
	more obvious"
	self notRendering 	
		ifTrue: [ ^ aString ].
	
	^ [ MicroDownParser asText: builder contents ] on: MicParsingError, MessageNotUnderstood, SubclassResponsibility  do: [ builder contents  ]
]
