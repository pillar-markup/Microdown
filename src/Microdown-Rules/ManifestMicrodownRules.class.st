"
Please describe the package using the class comment of the included manifest class. The manifest class also includes other additional metadata for the package. These meta data are used by other tools such as the SmalllintManifestChecker and the critics Browser
"
Class {
	#name : 'ManifestMicrodownRules',
	#superclass : 'PackageManifest',
	#category : 'Microdown-Rules-Manifest',
	#package : 'Microdown-Rules',
	#tag : 'Manifest'
}

{ #category : 'code-critics' }
ManifestMicrodownRules class >> ruleNotEliminationRuleV1FalsePositive [

	<ignoreForCoverage>
	^ #(#(#(#RGMethodDefinition #(#MicRuleUppercaseHeaderStrategy #checkRest:of: #false)) #'2026-03-05T07:42:00.35682+03:00') )
]

{ #category : 'code-critics' }
ManifestMicrodownRules class >> ruleUnclassifiedMethodsRuleV1FalsePositive [

	<ignoreForCoverage>
	^ #(#(#(#RGMethodDefinition #(#MicRuleUppercaseHeaderStrategy #checkRest:of: #false)) #'2026-03-05T07:41:58.207851+03:00') )
]
