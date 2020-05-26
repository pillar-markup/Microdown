"
To handle 

{
    ""title"": ""Selecting Expressions"",
    ""author"": ""S. Ducasse and L. Fabresse with Q. Ducasse"",
    ""subtitle"": """",
    ""slidesid"": ""W1-LiveA-EN""
}
"
Class {
	#name : #MicMetaDataBlock,
	#superclass : #GHMStartStopMarkupBlock,
	#category : #Microdown
}

{ #category : #markups }
MicMetaDataBlock >> lineStartMarkup [

	^ parser metaDataOpeningBlockMarkup
]

{ #category : #markups }
MicMetaDataBlock >> lineStopMarkup [

	^ parser metaDataClosingBlockMarkup 
]
