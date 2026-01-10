Class {
	#name : 'MicAnalysisReportWriterTest',
	#superclass : 'TestCase',
	#category : 'Microdown-BookTester-Tests',
	#package : 'Microdown-BookTester-Tests'
}

{ #category : 'tests' }
MicAnalysisReportWriterTest >> testWithEmptyResults [

	self assert: MicAnalysisReportWriter new report isEmpty
]

{ #category : 'tests' }
MicAnalysisReportWriterTest >> testWithResults [

	| reporter |
	reporter := MicAnalysisReportWriter new 
					addResults: { MicBrokenSyncDefinitionResult new };
					addResults: { MicBrokenSyncOriginDefinitionResult new }.
	self assert: reporter results size equals: 2. 
	self deny: reporter report isEmpty
]
