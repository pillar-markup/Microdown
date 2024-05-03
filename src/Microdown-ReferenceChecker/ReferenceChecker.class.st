"
***
***
A horizontal line
# Microdown Parser and Elements
```language=Pharo&caption=Beautiful&label=code1
Some code
```
[Pharo web site](http://www.pharo.org?alt=Pharo&key2=value2)
\![The famous Pharo Logo](https://files.pharo.org/media/logo/logo.
png?size=80&label=logo1)
\![This diagram shows...](file:///figures/diagram1.png?width=80&
label=fig1)
- item1
- item2
on two lines
- item 3
1. item one
3. item two
> This is
> a quote
"
Class {
	#name : 'ReferenceChecker',
	#superclass : 'MicrodownVisitor',
	#instVars : [
		'references',
		'anchors',
		'someError',
		'errorsList'
	],
	#category : 'Microdown-ReferenceChecker',
	#package : 'Microdown-ReferenceChecker'
}

{ #category : 'initialization' }
ReferenceChecker >> addAnchor: anObject [
    "Add an object to the anchors collection only if it is not already present and is not empty or whitespace."
        (anchors includes: anObject) ifTrue:[ self someError:true. self addError: ( anObject asString, '   is a duplicated anchor  ') ] ifFalse: [
            anchors add: anObject     
    ].
	 
]

{ #category : 'initialization' }
ReferenceChecker >> addError: anError [ 
	errorsList add: anError .
]

{ #category : 'initialization' }
ReferenceChecker >> addReference: anObject [
    | referenceString |
    "Check if the object is an instance of AnchorReferenceBlock"
   (anObject isKindOf: MicAnchorReferenceBlock )
        ifTrue: [ referenceString := anObject bodyString]  "Extract bodyString if it's an AnchorReferenceBlock"
        ifFalse: [ referenceString :=  anObject].  "Use the string as it is if it's not"

    "Check if the reference is already in the collection and add if not"
    (references includes: referenceString) ifFalse: [
        references add: referenceString
    ].



"addReference: anObject
		(references includes: anObject bodyString ) ifFalse: [
            references add:( anObject bodyString  )  
  	   ]."
"addReference: anObject
    | referenceName |
    ""Extract the part of the string after 'Reference:'""
    referenceName := anObject plainText allButFirst: 10.  ""Remove the first 10 characters 'Reference:'""

    ""Check if the extracted reference is already in the collection and add if not""
    (references includes: referenceName) ifFalse: [
        references add: referenceName
    ].
"
]

{ #category : 'initialization' }
ReferenceChecker >> anchors [
    ^ anchors

]

{ #category : 'initialization' }
ReferenceChecker >> anchors: anObject [
    anchors := anObject 
]

{ #category : 'initialization' }
ReferenceChecker >> does: anAnchors containAll: aReferences [
    | allContained |
    allContained := aReferences allSatisfy: [:eachReference | anAnchors includes: eachReference].
    
    (allContained and: [someError not])
        ifTrue: [
            "All references are contained and no prior error"
            ^ someError .
        ]
        ifFalse: [
            "Not all references are contained or there is some error"
            someError ifTrue: [^ someError].
            
            "Handle the error specific to containment"
            self addError: ('a reference point to unexisting anchor does not point to any anchor').
            ^ someError  "Return the error state, possibly updated by addError"
        ].

]

{ #category : 'initialization' }
ReferenceChecker >> error: aString [
    Transcript show: aString; cr.

]

{ #category : 'accessing' }
ReferenceChecker >> errorsList [

	^ errorsList
]

{ #category : 'accessing' }
ReferenceChecker >> errorsList: anObject [

	errorsList := anObject
]

{ #category : 'initialization' }
ReferenceChecker >> getAnchorAt: index [
    ^ anchors at: index ifAbsent: [ nil ].
]

{ #category : 'initialization' }
ReferenceChecker >> getReferenceAt: index [
    ^ references at: index ifAbsent: [ nil ].
]

{ #category : 'initialization' }
ReferenceChecker >> initialize [
    super initialize.
    references := OrderedCollection new.
    anchors := OrderedCollection new.
    errorsList := OrderedCollection new.
 	 someError := false .
]

{ #category : 'initialization' }
ReferenceChecker >> referenceCheck: aString [ 
	|source errorString |
	source := MicrodownParser parse: aString .
	self visitParentDocument: source . 
	self does: self anchors containAll: self references . 
	(someError )
		 ifTrue: 
			[ errorString := String streamContents: [:stream |
          errorsList do: [:error |
            stream nextPutAll: error; cr.
       					 ]
   		   ].
         ^ errorString
		  ]
	 ifFalse: [ 
					^ 'every thing worked fine'
		 ] 
	 
]

{ #category : 'initialization' }
ReferenceChecker >> references [
    ^ references
]

{ #category : 'initialization' }
ReferenceChecker >> references: anObject [
    references := anObject

]

{ #category : 'accessing' }
ReferenceChecker >> someError [

	^ someError
]

{ #category : 'accessing' }
ReferenceChecker >> someError: anObject [ " true indicates that there is an error but the value par default is false ( there is no error found while checking ) "

	someError := anObject
]

{ #category : 'initialization' }
ReferenceChecker >> visitAnchor: anAnchor [
    "Process an anchor node and optionally handle its children."
    self addAnchor: anAnchor label.
    
]

{ #category : 'initialization' }
ReferenceChecker >> visitAnchorReference: anAnchorReferenceBlock [
    self addReference: anAnchorReferenceBlock.
    "super visitAnchorReference: anAnchorReferenceBlock."
]

{ #category : 'initialization' }
ReferenceChecker >> visitDocumentRoot: aRoot [
    aRoot accept: self.
]

{ #category : 'initialization' }
ReferenceChecker >> visitParentDocument: aDocument [
    "Visit each child of the document root and process it."
    aDocument children do: [:child | 
        child accept: self
    ].
]

{ #category : 'initialization' }
ReferenceChecker >> visitRoot: anElement [
    "Check if the parent of the element correctly includes this element as a child"
    anElement parent ifNotNil: [ 
        (anElement parent children includes: anElement) ifFalse: [
            self addError: 'Parent does not include this element as a child'.
        ].
		
    ].
	Transcript show: 'hello'.
    anElement children do: [ :child |
        child parent = anElement ifFalse: [
            self addError: 'Child does not point back to the correct parent'.
        ].
        child accept: self  "Continue the visit recursively"
    ].
	Transcript show: 'hello 2'.
]
