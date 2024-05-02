Class {
	#name : 'MicReferenceCheckerVisitorTest',
	#superclass : 'TestCase',
	#instVars : [
		'visitor'
	],
	#category : 'Microdown-ReferenceChecker',
	#package : 'Microdown-ReferenceChecker'
}

{ #category : 'tests' }
MicReferenceCheckerVisitorTest >> testAllReferencesMatch [
    | visitor anchorBlock paragraph |
    visitor := MicReferenceCheckerVisitor new.
    anchorBlock := MicAnchorBlock new label: 'validAnchor'; yourself.
    paragraph := MicParagraphBlock new text: 'Refer to *@validAnchor@* for more information.'.
    visitor visitAnchor: anchorBlock.
    visitor visitParagraph: paragraph.
    self shouldnt: [ visitor validateReferences ] raise: Error.

]

{ #category : 'tests' }
MicReferenceCheckerVisitorTest >> testAnchorCollection [
    |  doc |
	doc := Microdown parse: '## Section1 
@section1


## Section 2
@section2

'.
    visitor := MicReferenceCheckerVisitor new.
	doc accept: visitor.
	self assert: visitor anchors size equals: 2. 
	
   
]

{ #category : 'tests' }
MicReferenceCheckerVisitorTest >> testAnchorCollectionReferencess [
    |  doc |
	doc := Microdown parse: '## Section1 
@section1

See *@section2@*

## Section 2
@section2

'.
    visitor := MicReferenceCheckerVisitor new.
	doc accept: visitor.
	self assert: visitor anchors size equals: 2. 
	self assert: visitor references size equals: 1
	
   
]

{ #category : 'tests' }
MicReferenceCheckerVisitorTest >> testInitialization [
  
    visitor := MicReferenceCheckerVisitor new.
    self assert: visitor anchors isEmpty.
    self assert: visitor references isEmpty.
]

{ #category : 'tests' }
MicReferenceCheckerVisitorTest >> testMultipleAnchorsSingleReference [
    | visitor anchor1 anchor2 paragraph |
    visitor := MicReferenceCheckerVisitor new.
    anchor1 := MicAnchorBlock new label: 'start'; yourself.
    anchor2 := MicAnchorBlock new label: 'end'; yourself.
    paragraph := MicParagraphBlock new text: 'Introduction *@start@*'.
    visitor visitAnchor: anchor1.
    visitor visitAnchor: anchor2.
    visitor visitParagraph: paragraph.
    self assert: (visitor references at: 'start' includes: paragraph).
    self assert: (visitor references includesKey: 'end') not.
    self assert: (visitor references includesKey: 'start').
    self shouldnt: [ visitor validateReferences ] raise: Error.
]

{ #category : 'tests' }
MicReferenceCheckerVisitorTest >> testNoAnchorsMultipleReferences [
    | visitor paragraph |
    visitor := MicReferenceCheckerVisitor new.
    paragraph := MicParagraphBlock new text: 'Referencing *@undefined@* and *@missing@*.'.
    visitor visitParagraph: paragraph.
    [ visitor validateReferences ] should raise: Error.
]

{ #category : 'tests' }
MicReferenceCheckerVisitorTest >> testParagraphContinuationAcrossLines [
    | visitor anchorBlock paragraph |
    visitor := MicReferenceCheckerVisitor new.
    anchorBlock := MicAnchorBlock new label: 'multiline'; yourself.
    paragraph := MicParagraphBlock new text: 'This is a long reference across *@multiline@* lines
that continues here.'.
    visitor visitAnchor: anchorBlock.
    visitor visitParagraph: paragraph.
    self assert: (visitor references at: 'multiline' includes: paragraph).
    self shouldnt: [ visitor validateReferences ] raise: Error.
]

{ #category : 'tests' }
MicReferenceCheckerVisitorTest >> testReferenceCollection [
    | visitor paragraph |
    visitor := MicReferenceCheckerVisitor new.
    paragraph := MicParagraphBlock new text: 'Refer to *@anchorSection@* for details.'.
    visitor visitParagraph: paragraph.
    self assert: (visitor references at: 'anchorSection' includes: paragraph).
]

{ #category : 'tests' }
MicReferenceCheckerVisitorTest >> testReferencesWithSpecialCharacters [
    | visitor anchorBlock paragraph |
    visitor := MicReferenceCheckerVisitor new.
    anchorBlock := MicAnchorBlock new label: 'special-char@123'; yourself.
    paragraph := MicParagraphBlock new text: 'Special cases *@special-char@123@*.'.
    visitor visitAnchor: anchorBlock.
    visitor visitParagraph: paragraph.
    self assert: (visitor anchors includesKey: 'special-char@123').
    self assert: (visitor references at: 'special-char@123' includes: paragraph).
    self shouldnt: [ visitor validateReferences ] raise: Error.
]

{ #category : 'tests' }
MicReferenceCheckerVisitorTest >> testUnmatchedReferences [
    | visitor paragraph |
    visitor := MicReferenceCheckerVisitor new.
    paragraph := MicParagraphBlock new text: 'See details in section *@missingAnchor@*.'.
    visitor visitParagraph: paragraph.
    [ visitor validateReferences ] should raise: Error.
]
