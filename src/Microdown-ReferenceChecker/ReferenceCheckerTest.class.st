Class {
	#name : 'ReferenceCheckerTest',
	#superclass : 'TestCase',
	#instVars : [
		'visitor'
	],
	#category : 'Microdown-ReferenceChecker',
	#package : 'Microdown-ReferenceChecker'
}

{ #category : 'running' }
ReferenceCheckerTest >> setUp [
    visitor := ReferenceChecker new.
    
]

{ #category : 'running' }
ReferenceCheckerTest >> testAllReferencesAreContained [
    visitor addAnchor: 'Ref1'; addAnchor: 'Ref2'; addAnchor: 'Ref3'.
    visitor references add: 'Ref1';  add: 'Ref2'.
    self assert: (visitor does: visitor anchors containAll: visitor references) equals: false.

]

{ #category : 'running' }
ReferenceCheckerTest >> testAnchors [ 
	| source root parser   source2|
	parser := MicrodownParser new.
	source := '@anchorSection',String cr,'@anchorSection2','@anchorSection',String  cr,'@anchorSection2'.
	root := parser parse: source.
	root children do: [:child | child accept: visitor ] .
	self assert: visitor anchors size  equals: 3 . 
	
	"making sure it does not duplicate the same anchors "
	source2 := '@anchorSection',String cr,'@anchorSection2','@anchorSection',String cr,'@anchorSection2'.
	root := parser parse: source2.
	root children do: [:child | child accept: visitor ] .
	self assert: visitor anchors size  equals: 3 . 
	 
]

{ #category : 'running' }
ReferenceCheckerTest >> testAnchorsInTextBlocks [
    | source root parser  |
    parser := MicrodownParser new.
    source := 'Text before @anchorSection and text after', String cr, 'Another line here @anchorSection2'.
    root := parser parse: source.
    root children do: [:child | child accept: visitor].
    self assert: visitor anchors size equals: 0.
]

{ #category : 'running' }
ReferenceCheckerTest >> testAnchorsWithDifferentNewLines [
    | source root parser  |
    parser := MicrodownParser new.
    source := '@anchorSection', String cr, '@anchorSection2', String lf, '@anchorSection3', String crlf.
    root := parser parse: source.
    visitor := ReferenceChecker new.
    root children do: [:child | child accept: visitor].
    self assert: visitor anchors size equals: 3.
]

{ #category : 'running' }
ReferenceCheckerTest >> testAnchorsWithSpecialCharacters [
    visitor addAnchor: 'Ref1 special'; addAnchor: 'Ref@#3'.
    visitor references add: 'Ref1 special';  add: 'Ref@#3'.
    self assert: (visitor does: visitor anchors containAll: visitor references) equals: false.

]

{ #category : 'running' }
ReferenceCheckerTest >> testAnchorss [  "no need to iterate the children in client side  "
    | source root parser  |
    parser := MicrodownParser new.
    source := '@anchorSection', String cr, '@anchorSection2', '@anchorSection', String cr, '@anchorSection2'.
    
    "Parse the document and visit it with the visitor"
    root := parser parse: source.
    visitor visitParentDocument: root.
    
    self assert: visitor anchors size equals: 3.

    "Making sure it does not duplicate the same anchors with a reparse"
    root := parser parse: source.
    visitor visitParentDocument: root.
    self assert: visitor anchors size equals: 3.

]

{ #category : 'running' }
ReferenceCheckerTest >> testBasicAnchorCollection [
    | source root parser  |
    parser := MicrodownParser new.
    source := '@anchorSection'.
    root := parser parse: source.
    root children do: [:child | child accept: visitor].
    self assert: visitor anchors size equals: 1.

]

{ #category : 'running' }
ReferenceCheckerTest >> testBothCollectionsEmpty [
    self assert: (visitor does: visitor anchors containAll: visitor references) equals: false.

]

{ #category : 'running' }
ReferenceCheckerTest >> testContainmentWhenAllReferencesAreContained [
    visitor addAnchor: 'Ref1'; addAnchor: 'Ref2'; addAnchor: 'Ref3'.
    visitor references add: 'Ref1'; add: 'Ref2'; add: 'Ref3'.
    self assert: (visitor does: visitor anchors containAll: visitor references) equals: false.
]

{ #category : 'running' }
ReferenceCheckerTest >> testContainmentWhenBothAreEmpty [
    self assert: (visitor does: visitor anchors containAll: visitor references) equals: false.
]

{ #category : 'running' }
ReferenceCheckerTest >> testContainmentWhenNotAllReferencesAreContained [
    visitor addAnchor: 'Ref1'; addAnchor: 'Ref3'.
    visitor references add: 'Ref1'; add: 'Ref2'; add: 'Ref3'.
    self assert: (visitor does: visitor anchors containAll: visitor references) equals: false.

]

{ #category : 'running' }
ReferenceCheckerTest >> testContainmentWithDuplicateReferences [
    visitor addAnchor: 'Ref1'; addAnchor: 'Ref2'.
    visitor references add: 'Ref1'; add: 'Ref1'.
    self assert: (visitor does: visitor anchors containAll: visitor references) equals: false.

]

{ #category : 'running' }
ReferenceCheckerTest >> testContainmentWithEmptyAnchors [
    visitor addReference: 'Ref1'.
    self assert: (visitor does: visitor anchors containAll: visitor references) equals: false.

]

{ #category : 'running' }
ReferenceCheckerTest >> testContainmentWithEmptyReferences [
    visitor addAnchor: 'Ref1'; addAnchor: 'Ref2'; addAnchor: 'Ref3'.
    self assert: (visitor does: visitor anchors containAll: visitor references) equals: false.
]

{ #category : 'running' }
ReferenceCheckerTest >> testDuplicateAnchors [
    | source root parser  |
    parser := MicrodownParser new.
    source := '@anchorSection', String cr, '@anchorSection'.
    root := parser parse: source.
    root children do: [:child | child accept: visitor].
    self assert: visitor anchors size equals: 1.  "If the system should ignore duplicates within a single document"
]

{ #category : 'running' }
ReferenceCheckerTest >> testDuplicateReferences [

    visitor addAnchor: 'Ref1' ;addAnchor: 'Ref2'.
 	 visitor addReference: 'Ref1' ;addReference: 'Ref1'.
    self assert: (visitor does: visitor anchors containAll: visitor references) equals: false.

]

{ #category : 'running' }
ReferenceCheckerTest >> testDuplicateReferencesWithAnchors [
    visitor addAnchor: 'Ref1'; addAnchor: 'Ref2'.
    visitor addReference: 'Ref1'; addReference: 'Ref1'.
    self assert: (visitor does: visitor anchors containAll: visitor references) equals: false.

]

{ #category : 'running' }
ReferenceCheckerTest >> testEmptyAnchors [
    visitor addReference: 'Ref1'.
    self assert: (visitor does: visitor anchors containAll: visitor references) equals: false.

]

{ #category : 'running' }
ReferenceCheckerTest >> testEmptyReferences [
    visitor addAnchor: 'Ref1'; addAnchor: 'Ref2'; addAnchor: 'Ref3'.
    self assert: (visitor does: visitor anchors containAll: visitor references) equals: false.

]

{ #category : 'running' }
ReferenceCheckerTest >> testInvalidReferenceTypes [
    visitor addAnchor: 'Ref1'; addAnchor: 'Ref3'.
    visitor addReference: 123; addReference: true.  "// Non-string references"
    self assert: (visitor does: visitor anchors containAll: visitor references) equals: false.
]

{ #category : 'running' }
ReferenceCheckerTest >> testMismatchedReferences [
    visitor addAnchor: 'Ref1'; addAnchor: 'Ref3'.
    visitor addReference: 'Ref2'; addReference: 'Ref4' ."  // Intentionally mismatched"
    self assert: (visitor does: visitor anchors containAll: visitor references) equals: false.
]

{ #category : 'running' }
ReferenceCheckerTest >> testNestedSectionsMultipleReferences [
    | source |
    source := MicrodownParser parse: '## Introduction
@intro
This section introduces concepts discussed in the *@methods@* and *@results@* sections.

## Methods
@methods
We describe our methods here. Refer back to the *@intro@* for basics.

## Results
@results
The results are discussed in-depth here. Refer to *@methods@* and *@discussion@* for more detail.

## Discussion
@discussion
Here we discuss the outcomes. Initial thoughts are back in *@intro@*.

## Conclusion
@conclusion
For final thoughts, see *@discussion@*. Remember the start in *@intro@*.
'.
    visitor visitParentDocument: source.
    self assert: (visitor does: visitor anchors containAll: visitor references) equals: false.

]

{ #category : 'running' }
ReferenceCheckerTest >> testNonStringElements [
    visitor addAnchor: 1; addAnchor: 2; addAnchor: 3.
    visitor addReference: 1; addReference: 2.
    self assert: (visitor does: visitor anchors containAll: visitor references) equals: false.

]

{ #category : 'running' }
ReferenceCheckerTest >> testNullReferences [
    visitor addAnchor: 'Ref1'; addAnchor: 'Ref2'.
    visitor addReference: nil. "// Adding a nil reference"
    self assert: (visitor does: visitor anchors containAll: visitor references) equals: false.
]

{ #category : 'running' }
ReferenceCheckerTest >> testReferenceNotContained [
    visitor addAnchor: 'Ref1'; addAnchor: 'Ref3'.
    visitor addReference: 'Ref1'; addReference: 'Ref2'.
    self assert: (visitor does: visitor anchors containAll: visitor references) equals: false.

]

{ #category : 'running' }
ReferenceCheckerTest >> testReferences [
    | source|
    "Initialize source with multiple references"
    source := Microdown parse: '## Section1 
@section1

See *@section2@*

## Section 2
@section2

'.
    "Process the document to collect references"
	 visitor visitParentDocument: source .
    self assert: visitor references size equals: 1.
]

{ #category : 'running' }
ReferenceCheckerTest >> testReferencesWithoutAnchors [
    | source  |

    source := MicrodownParser parse: '## Introduction
@intro
This section introduces concepts that will be discussed.

## Methods
@methods
Detailed methodologies are described here. See details in *@nonExistentAnchor@*.

## Results
@results
Results are discussed, with further insights in *@furtherInsights@* that do not exist.

'.
    visitor visitParentDocument: source.
    self assert:  (visitor does: visitor anchors containAll: visitor references)  equals: false .
]

{ #category : 'running' }
ReferenceCheckerTest >> testRejectingEmptyAndWhitespaceAnchors [
    | emptyAnchor whitespaceAnchor |
    emptyAnchor := ''.
    whitespaceAnchor := '   '.

    ReferenceChecker new addAnchor: emptyAnchor.
    ReferenceChecker new addAnchor: whitespaceAnchor.

    self assert: ReferenceChecker new anchors isEmpty.
]

{ #category : 'running' }
ReferenceCheckerTest >> testRepeatedAnchors [
    | source  |

    source := MicrodownParser parse: '## Introduction
@intro
Refer to *@intro@* again for emphasis.

## Methods
@intro
This is incorrectly tagged but uses the same anchor as the introduction.

## Discussion
@discussion
Discussion points back to *@intro@* multiple times.
'.
    visitor visitParentDocument: source.
    self assert:  (visitor does: visitor anchors containAll: visitor references)  equals: true .
]
