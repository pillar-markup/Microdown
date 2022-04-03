"
I am rather early in my design and development phase, so all comments are welcome
"
Class {
	#name : #ManifestMicrodownDocumentBrowser,
	#superclass : #PackageManifest,
	#category : #'Microdown-DocumentBrowser-Manifest'
}

{ #category : #'code-critics' }
ManifestMicrodownDocumentBrowser class >> ruleAnySatisfyRuleV1FalsePositive [
	^ #(#(#(#RGMethodDefinition #(#MicClassAndPacketDocProvider #addClassesIn:to: #false)) #'2022-03-01T13:43:05.239383+01:00') )
]

{ #category : #'code-critics' }
ManifestMicrodownDocumentBrowser class >> ruleBadMessageRule2V1FalsePositive [
	^ #(#(#(#RGMethodDefinition #(#MicDocumentCollection #provider #false)) #'2022-02-09T08:50:19.807649+01:00') )
]

{ #category : #'code-critics' }
ManifestMicrodownDocumentBrowser class >> ruleCascadedNextPutAllsRuleV1FalsePositive [
	^ #(#(#(#RGMethodDefinition #(#MicSectionBlock #displayStringOn: #false)) #'2022-01-13T08:09:02.083859+01:00') )
]

{ #category : #'code-critics' }
ManifestMicrodownDocumentBrowser class >> ruleTempsReadBeforeWrittenRuleV1FalsePositive [
	^ #(#(#(#RGMethodDefinition #(#MicGithubDocProvider #loadDocuments #false)) #'2022-02-03T06:45:59.503761+01:00') )
]
