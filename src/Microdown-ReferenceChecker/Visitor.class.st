Class {
	#name : 'Visitor',
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
Visitor >> addAnchor: anObject [
    "Add an object to the anchors collection only if it is not already present and is not empty or whitespace."
        (anchors includes: anObject) ifTrue:[ self someError:true. self addError: ( anObject asString, '   is a duplicated anchor  ') ] ifFalse: [
            anchors add: anObject     
    ].
	 
]

{ #category : 'initialization' }
Visitor >> addError: anError [ 
	errorsList add: anError .
]

{ #category : 'initialization' }
Visitor >> addReference: anObject [
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
Visitor >> anchors [
    ^ anchors

]

{ #category : 'initialization' }
Visitor >> anchors: anObject [
    anchors := anObject 
]

{ #category : 'initialization' }
Visitor >> does: anAnchors containAll: aReferences [
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
Visitor >> error: aString [
    Transcript show: aString; cr.

]

{ #category : 'accessing' }
Visitor >> errorsList [

	^ errorsList
]

{ #category : 'accessing' }
Visitor >> errorsList: anObject [

	errorsList := anObject
]

{ #category : 'initialization' }
Visitor >> getAnchorAt: index [
    ^ anchors at: index ifAbsent: [ nil ].
]

{ #category : 'initialization' }
Visitor >> getReferenceAt: index [
    ^ references at: index ifAbsent: [ nil ].
]

{ #category : 'initialization' }
Visitor >> initialize [
    super initialize.
    references := OrderedCollection new.
    anchors := OrderedCollection new.
    errorsList := OrderedCollection new.
 	 someError := false .
]

{ #category : 'initialization' }
Visitor >> referenceCheck: aString [ 
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
Visitor >> references [
    ^ references
]

{ #category : 'initialization' }
Visitor >> references: anObject [
    references := anObject

]

{ #category : 'accessing' }
Visitor >> someError [

	^ someError
]

{ #category : 'accessing' }
Visitor >> someError: anObject [ " true indicates that there is an error but the value par default is false ( there is no error found while checking ) "

	someError := anObject
]

{ #category : 'initialization' }
Visitor >> visitAnchor: anAnchor [
    "Process an anchor node and optionally handle its children."
    self addAnchor: anAnchor label.
    
]

{ #category : 'initialization' }
Visitor >> visitAnchorReference: anAnchorReferenceBlock [
    self addReference: anAnchorReferenceBlock.
    "super visitAnchorReference: anAnchorReferenceBlock."
]

{ #category : 'initialization' }
Visitor >> visitDocumentRoot: aRoot [
    aRoot accept: self.
]

{ #category : 'initialization' }
Visitor >> visitParentDocument: aDocument [
    "Visit each child of the document root and process it."
    aDocument children do: [:child | 
        child accept: self
    ].
]

{ #category : 'initialization' }
Visitor >> visitRoot: anElement [
    "Check if the parent of the element correctly includes this element as a child"
    anElement parent ifNotNil: [ 
        (anElement parent children includes: anElement) ifFalse: [
            self addError: 'Parent does not include this element as a child'.
        ].
    ].
    anElement children do: [ :child |
        child parent = anElement ifFalse: [
            self addError: 'Child does not point back to the correct parent'.
        ].
        child accept: self  "Continue the visit recursively"
    ].
]
